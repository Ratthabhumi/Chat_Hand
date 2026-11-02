// EXPERIMENTAL PROTOTYPE ONLY - DO NOT DEPLOY TO PRODUCTION OR EXPOSE TO INTERNET
// This gateway prototype was created for offline evaluation of tool filtering concepts.
// It is NOT installed in the active MCP transport path. Path validation is synthetic and
// does not constitute a hardened Windows OS filesystem boundary.

import path from 'node:path';

export const DEFAULT_ALLOWED_TOOLS = Object.freeze([
  'read_file',
  'write_file',
  'edit_file',
  'list_directory',
  'directory_tree',
  'search_files',
  'get_file_info',
  'workspace',
  'skills',
  'dwb_broker_status',
  'dwb_session_status'
]);

export const DEFAULT_BLOCKED_TOOLS = Object.freeze([
  'start_process',
  'interact_with_process',
  'kill_process',
  'force_terminate',
  'set_config_value',
  'execute_code'
]);

export class McpToolFilterGateway {
  constructor(options = {}) {
    this.allowedTools = new Set(options.allowedTools || DEFAULT_ALLOWED_TOOLS);
    this.blockedTools = new Set(options.blockedTools || DEFAULT_BLOCKED_TOOLS);
    this.sandboxPath = options.sandboxPath ? path.resolve(options.sandboxPath) : null;
    this.auditLog = [];
  }

  filterToolList(tools = []) {
    return tools.filter(tool => {
      if (!tool || !tool.name) return false;
      if (this.blockedTools.has(tool.name)) return false;
      return this.allowedTools.has(tool.name);
    });
  }

  validateToolCall(toolName, args = {}) {
    // 1. Tool name validation
    if (!toolName || typeof toolName !== 'string') {
      return { allowed: false, reason: 'Invalid tool name' };
    }

    if (this.blockedTools.has(toolName)) {
      this._recordAudit(toolName, 'BLOCKED_HIGH_RISK_TOOL');
      return {
        allowed: false,
        reason: `Access Denied: Tool '${toolName}' is blocked by security policy (process/config tools denied).`
      };
    }

    if (!this.allowedTools.has(toolName)) {
      this._recordAudit(toolName, 'NOT_IN_ALLOWLIST');
      return {
        allowed: false,
        reason: `Access Denied: Tool '${toolName}' is not in the approved allowlist.`
      };
    }

    // 2. Path sandboxing validation for filesystem tools
    if (args && args.path && typeof args.path === 'string' && this.sandboxPath) {
      const normalizedPath = path.resolve(args.path);
      const isTraversal = args.path.includes('..');
      const isInsideSandbox = normalizedPath.startsWith(this.sandboxPath + path.sep) || normalizedPath === this.sandboxPath;

      if (isTraversal || !isInsideSandbox) {
        this._recordAudit(toolName, 'PATH_ESCAPE_DENIED');
        return {
          allowed: false,
          reason: `Access Denied: Path escapes approved sandbox (${this.sandboxPath}).`
        };
      }
    }

    return { allowed: true };
  }

  _recordAudit(toolName, event) {
    this.auditLog.push({
      timestamp: new Date().toISOString(),
      tool: toolName,
      event
    });
  }
}
