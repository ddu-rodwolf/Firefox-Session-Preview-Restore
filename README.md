# 🦊 Firefox Session Preview & Restore

![Bash](https://img.shields.io/badge/language-Bash-green)
![Python](https://img.shields.io/badge/language-Python-blue)
![jq](https://img.shields.io/badge/tool-jq-orange)
![License: Apache 2.0](https://img.shields.io/badge/license-Apache%202.0-blue)

A cross-toolkit solution to **preview, restore, and back up Firefox session data** from multiple profiles.  
Currently includes a **Python utility** for decoding Firefox’s LZ4-compressed session files into plain JSON for use with `jq` or other processing tools.

<details>
<summary>Click to expand project summary</summary>
&nbsp;

**Why this project?**  
Firefox (and most browsers) lack convenient tools to:
- 🛠 **Recover lost sessions** after accidentally clicking “Start new session” instead of “Restore session”
- 📜 **Search past browsing history** to retrieve forgotten references months later  
- 🗂 Manage multiple profiles with **hundreds of grouped tabs** without relying solely on browser UI

This project fills that gap — especially useful for research-intensive workflows involving multiple session profiles and tab groups.  
For example, the author regularly works with **6 Firefox profiles** in parallel, each containing numerous postponed or ongoing projects.

Planned adaptation for **Microsoft Edge** is also considered, for environments where Edge is the primary work browser.

**Core capabilities** (full release goal):
- 🔍 Preview saved sessions and tabs (with color-coded grouping)
- 🗄 Back up session data for safe archival
- ♻ Restore sessions selectively
- 🐍 Python LZ4 decoder for use with `jq` and shell pipelines

</details>

---

## 📦 Current Release Status

> **Note:** Full Bash/JQ preview & restore scripts are **under development**.  
> The **Python decoder** is published now for early adopters and integration testing.

### `decode_jsonlz4.py`
A minimal Python utility to decode Firefox’s `mozLz40\0` LZ4-compressed session files.

**Usage:**
```bash
./decode_jsonlz4.py /path/to/sessionstore.jsonlz4 | jq .
