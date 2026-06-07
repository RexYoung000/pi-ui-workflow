/**
 * Agent discovery 模块
 *
 * 在标准 loadAgentsFromDir（用户 ~/.pi/agent/agents/、项目 .pi/agents/）之外，额外加载
 * 当前 npm package 内的 .pi/agents/，这样用户 pi install 后无需手动复制 agents。
 */

import * as fs from "node:fs";
import * as path from "node:path";
import { getAgentDir, parseFrontmatter } from "@earendil-works/pi-coding-agent";

export type AgentScope = "user" | "project" | "both";

export interface AgentConfig {
	name: string;
	description: string;
	tools?: string[];
	model?: string;
	systemPrompt: string;
	source: "user" | "project" | "package";
	filePath: string;
}

export interface AgentDiscoveryResult {
	agents: AgentConfig[];
	projectAgentsDir: string | null;
}

/* ---------- 工具函数 ---------- */

function loadAgentsFromDir(dir: string, source: "user" | "project" | "package"): AgentConfig[] {
	const agents: AgentConfig[] = [];
	if (!fs.existsSync(dir)) return agents;

	let entries: fs.Dirent[];
	try {
		entries = fs.readdirSync(dir, { withFileTypes: true });
	} catch {
		return agents;
	}

	for (const entry of entries) {
		if (!entry.name.endsWith(".md")) continue;
		if (!entry.isFile() && !entry.isSymbolicLink()) continue;

		const filePath = path.join(dir, entry.name);
		let content: string;
		try {
			content = fs.readFileSync(filePath, "utf-8");
		} catch {
			continue;
		}

		const { frontmatter, body } = parseFrontmatter<Record<string, string>>(content);
		if (!frontmatter.name || !frontmatter.description) continue;

		const tools = frontmatter.tools
			?.split(",")
			.map((t: string) => t.trim())
			.filter(Boolean);

		agents.push({
			name: frontmatter.name,
			description: frontmatter.description,
			tools: tools && tools.length > 0 ? tools : undefined,
			model: frontmatter.model,
			systemPrompt: body,
			source,
			filePath,
		});
	}
	return agents;
}

function isDirectory(p: string): boolean {
	try {
		return fs.statSync(p).isDirectory();
	} catch {
		return false;
	}
}

function findNearestProjectAgentsDir(cwd: string): string | null {
	let currentDir = cwd;
	while (true) {
		const candidate = path.join(currentDir, ".pi", "agents");
		if (isDirectory(candidate)) return candidate;
		const parentDir = path.dirname(currentDir);
		if (parentDir === currentDir) return null;
		currentDir = parentDir;
	}
}

/**
 * 获取当前 package 内的 .pi/agents/ 绝对路径。
 * 本文件位于 <package>/extensions/ui-workflow/agents.ts，
 * 所以 `__dirname` 往回两级即 package 根目录。
 */
function getPackageAgentsDir(): string | null {
	let dir: string;
	try {
		dir = path.resolve(__dirname, "..", "..", ".pi", "agents");
	} catch {
		return null;
	}
	return isDirectory(dir) ? dir : null;
}

/* ---------- 主入口 ---------- */

export function discoverAgents(cwd: string, scope: AgentScope): AgentDiscoveryResult {
	const userDir = path.join(getAgentDir(), "agents");
	const projectAgentsDir = findNearestProjectAgentsDir(cwd);
	const packageAgentsDir = getPackageAgentsDir();

	const agentMap = new Map<string, AgentConfig>();

	// 1. 用户全局
	if (scope !== "project") {
		for (const agent of loadAgentsFromDir(userDir, "user")) {
			agentMap.set(agent.name, agent);
		}
	}

	// 2. 项目本地（如 scope 为 both 或 project）
	if (scope !== "user" && projectAgentsDir) {
		for (const agent of loadAgentsFromDir(projectAgentsDir, "project")) {
			agentMap.set(agent.name, agent);
		}
	}

	// 3. Package 内置（最高优先级，覆盖同名 agents）
	if (packageAgentsDir) {
		for (const agent of loadAgentsFromDir(packageAgentsDir, "package")) {
			agentMap.set(agent.name, agent);
		}
	}

	return { agents: Array.from(agentMap.values()), projectAgentsDir };
}

export function formatAgentList(agents: AgentConfig[], maxItems: number): { text: string; remaining: number } {
	if (agents.length === 0) return { text: "none", remaining: 0 };
	const listed = agents.slice(0, maxItems);
	const remaining = agents.length - listed.length;
	return {
		text: listed.map((a) => `${a.name} (${a.source}): ${a.description}`).join("; "),
		remaining,
	};
}
