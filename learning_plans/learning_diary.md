# Day 1 – 13/05/2025

## ✅ Learning

- Organised Obsidian and its many features.
- Learned about roles in IT support and why users matter.

## 🛠️ Practiced
- Created support-toolkit.sh on Arch
- Output: Disk usage, IP, Failed services
- Learned to use df, ps, systemctl

## 🧪 Cyber

- Concepts: CIA Triad, risk = threat x vulnerability

## 💭 Reflection
Started with clarity. Linux comfort helped. Need to revisit the difference between services and daemons.

## Day 2 Learnings – OS & Hardware
- Binary = [explain]
- Kernel = [explain]
- One thing I didn’t realize about RAM vs storage:

## Day 3
### What I Built
- battery-check.sh → learned to use `if`, `else`
- disk-check.sh → real script for checking root usage

### What I Learned
- Bash uses `-lt`, `-gt`, and `==` for comparisons
- `if [...]` evaluates logic based on output codes
- Real scripts need fallback paths (`else`)

### Still Confused About
- When do I need `[[ ... ]]` instead of `[ ... ]`?
- What does `exit 0` do at the end of scripts?

### Next
- Try creating my own “internet-check.sh”

# Day 4 – Loops

### What I Built
- loop-names.sh → practiced `for` syntax
- ping-websites.sh → ping test with logic
- countdown.sh → first `while` loop
- log-size-checker → looped over real files

### What I Learned
- Loops let me repeat logic over changing data
- `$?` is super useful to check success/failure
- I feel more confident chaining logic now

### What I Want to Try
- Loop through all system users and check disk usage
- Monitor system health every 5 mins (cron?)