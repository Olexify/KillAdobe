# 🧨 KillAdobe

A simple Windows utility that kills all Adobe background processes from RAM with a single click.

Just run the `.bat` file (which calls PowerShell scripts under the hood) and Adobe gets instantly terminated.

---

## ⚙️ How it works

- Lightweight batch script
- Executes PowerShell commands
- Force-kills all running Adobe processes
- Can be launched manually or via shortcut

You can also assign it a custom icon and use it like a normal desktop app shortcut.

---

## 😂 Dad jokes (optional but included)

- Miners mine crypto. Adobers mine your CPU at startup.
- When life hits rock bottom, AI yoinks your GPUs… Adobe deploys 14 background processes for emotional support.
- Bad day? AIs took all the SSDs. Adobe took the rest of your RAM ❤️

---

## 🚀 Running at Windows startup

If you want this script to run automatically when Windows starts:

### 1. Disable Adobe startup (recommended)
You can do this via:
- Windows Settings → Startup Apps  
- Registry tools (e.g. Reg Organizer)  
- Microsoft Sysinternals Autoruns

📌 Sysinternals Autoruns:
https://learn.microsoft.com/en-us/sysinternals/downloads/autoruns

It shows everything that starts with Windows and lets you disable deep startup entries.

---

### 2. Add script to startup folder

Press:

```
Win + R
```

Then type:

```
shell:startup
```

This opens the Windows Startup folder.

Place a shortcut to your `.bat` file inside this folder — it will run automatically on login.

---

### ⚠️ Important note

If Adobe is configured with delayed or background startup, it may launch *after* your script runs.

In that case:
- Either add a delay to your script
- Or fully disable Adobe startup (recommended)

---

## 🧠 Philosophy

This tool exists for one reason:

Adobe background processes should not behave like a cryptocurrency miner disguised as a creative suite.

---

## ⚠️ Safety warning

Be careful when disabling startup services.

- Always know what you're turning off  
- Take screenshots or backups before modifying system startup entries  
- Some services may be required for other software

---

## 💡 Summary

- One-click Adobe process killer  
- Lightweight and simple  
- Works manually or at startup  
- Built for people who want control over background bloat  

---

> Now you know the truth.
