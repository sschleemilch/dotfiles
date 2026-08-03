import { appendFile } from "node:fs/promises";
import { fileURLToPath } from "node:url";
import { dirname, join } from "node:path";
import { homedir } from "node:os";
import type { Plugin } from "@opencode-ai/plugin";

// const logPath = join(dirname(fileURLToPath(import.meta.url)), "kitty.log");

export const Kitty: Plugin = async ({ $ }) => ({
  event: async ({ event }) => {

    // await appendFile(
    //   logPath,
    //   `${new Date().toISOString()} ${JSON.stringify(event)}\n`,
    // ).catch(() => {});

    let status: string | undefined;

    switch (event.type) {
      case "session.status":
        status = event.properties.status.type === "busy" ? "working" : "idle";
        break;
      case "session.idle":
        status = "idle";
        break;
      case "permission.updated":
        status = "needs-input";
        break;
      case "permission.replied":
        status = "working";
        break;
      case "question.asked":
        status = "needs-input";
        break;
      case "question.replied":
        status = "working";
        break;
    }

    if (!status) return;

    await $`${homedir()}/.config/opencode/plugins/agent-status.sh ${status}`;
  },
});
