# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_opencli_rs_global_optspecs
	string join \n f/format= v/verbose h/help V/version
end

function __fish_opencli_rs_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_opencli_rs_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_opencli_rs_using_subcommand
	set -l cmd (__fish_opencli_rs_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -s V -l version -d 'Print version'
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "antigravity"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "apple-podcasts"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "arxiv"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "barchart"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "bbc"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "bilibili"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "bloomberg"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "boss"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "chaoxing"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "chatgpt"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "chatwise"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "codex"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "coupang"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "ctrip"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "cursor"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "devto"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "discord-app"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "douban"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "doubao"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "doubao-app"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "facebook"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "google"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "grok"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "hackernews"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "hf"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "instagram"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "jike"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "jimeng"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "linkedin"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "linux-do"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "lobsters"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "medium"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "notion"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "reddit"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "reuters"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "sinablog"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "sinafinance"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "smzdm"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "stackoverflow"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "steam"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "substack"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "tiktok"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "twitter"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "v2ex"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "weibo"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "weixin"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "weread"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "wikipedia"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "xiaohongshu"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "xiaoyuzhou"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "xueqiu"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "yahoo-finance"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "yollomi"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "youtube"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "zhihu"
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "gh" -d 'GitHub CLI — repos, PRs, issues, releases, gists'
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "obsidian" -d 'Obsidian vault management — notes, search, tags, tasks, sync'
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "readwise" -d 'Readwise & Reader CLI — highlights, annotations, reading list'
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "kubectl" -d 'Kubernetes command-line tool'
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "docker" -d 'Docker command-line interface'
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "gws" -d 'Google Workspace CLI — Docs, Sheets, Drive, Gmail, Calendar'
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "doctor" -d 'Run diagnostics checks'
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "completion" -d 'Generate shell completions'
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "explore" -d 'Explore a website\'s API surface and discover endpoints'
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "cascade" -d 'Auto-detect authentication strategy for an API endpoint'
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "generate" -d 'One-shot: explore + synthesize + select best adapter'
complete -c opencli-rs -n "__fish_opencli_rs_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and not __fish_seen_subcommand_from dump extract-code model new read send serve status watch help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and not __fish_seen_subcommand_from dump extract-code model new read send serve status watch help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and not __fish_seen_subcommand_from dump extract-code model new read send serve status watch help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and not __fish_seen_subcommand_from dump extract-code model new read send serve status watch help" -f -a "dump" -d 'Dump the DOM to help AI understand the UI'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and not __fish_seen_subcommand_from dump extract-code model new read send serve status watch help" -f -a "extract-code" -d 'Extract multi-line code blocks from the current Antigravity conversation'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and not __fish_seen_subcommand_from dump extract-code model new read send serve status watch help" -f -a "model" -d 'Get or change the active AI model in Antigravity'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and not __fish_seen_subcommand_from dump extract-code model new read send serve status watch help" -f -a "new" -d 'Start a new Antigravity conversation'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and not __fish_seen_subcommand_from dump extract-code model new read send serve status watch help" -f -a "read" -d 'Read the current Antigravity conversation'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and not __fish_seen_subcommand_from dump extract-code model new read send serve status watch help" -f -a "send" -d 'Send a message to Antigravity'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and not __fish_seen_subcommand_from dump extract-code model new read send serve status watch help" -f -a "serve" -d 'Check if Antigravity is being served / accessible'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and not __fish_seen_subcommand_from dump extract-code model new read send serve status watch help" -f -a "status" -d 'Check active CDP connection to Antigravity'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and not __fish_seen_subcommand_from dump extract-code model new read send serve status watch help" -f -a "watch" -d 'Watch for new messages in Antigravity conversation'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and not __fish_seen_subcommand_from dump extract-code model new read send serve status watch help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from dump" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from dump" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from dump" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from extract-code" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from extract-code" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from extract-code" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from model" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from model" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from model" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from new" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from new" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from new" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from read" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from read" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from read" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from send" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from send" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from send" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from serve" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from serve" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from serve" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from status" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from status" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from status" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from watch" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from watch" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from watch" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from help" -f -a "dump" -d 'Dump the DOM to help AI understand the UI'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from help" -f -a "extract-code" -d 'Extract multi-line code blocks from the current Antigravity conversation'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from help" -f -a "model" -d 'Get or change the active AI model in Antigravity'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from help" -f -a "new" -d 'Start a new Antigravity conversation'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from help" -f -a "read" -d 'Read the current Antigravity conversation'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from help" -f -a "send" -d 'Send a message to Antigravity'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from help" -f -a "serve" -d 'Check if Antigravity is being served / accessible'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from help" -f -a "status" -d 'Check active CDP connection to Antigravity'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from help" -f -a "watch" -d 'Watch for new messages in Antigravity conversation'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand antigravity; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and not __fish_seen_subcommand_from episodes search top help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and not __fish_seen_subcommand_from episodes search top help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and not __fish_seen_subcommand_from episodes search top help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and not __fish_seen_subcommand_from episodes search top help" -f -a "episodes" -d 'List recent episodes of an Apple Podcast (use ID from search)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and not __fish_seen_subcommand_from episodes search top help" -f -a "search" -d 'Search Apple Podcasts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and not __fish_seen_subcommand_from episodes search top help" -f -a "top" -d 'Top podcasts chart on Apple Podcasts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and not __fish_seen_subcommand_from episodes search top help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and __fish_seen_subcommand_from episodes" -l limit -d 'Max episodes to show' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and __fish_seen_subcommand_from episodes" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and __fish_seen_subcommand_from episodes" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and __fish_seen_subcommand_from episodes" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and __fish_seen_subcommand_from search" -l limit -d 'Max results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and __fish_seen_subcommand_from top" -l country -d 'Country code (e.g. us, cn, gb, jp)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and __fish_seen_subcommand_from top" -l limit -d 'Number of podcasts (max 100)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and __fish_seen_subcommand_from top" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and __fish_seen_subcommand_from top" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and __fish_seen_subcommand_from top" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and __fish_seen_subcommand_from help" -f -a "episodes" -d 'List recent episodes of an Apple Podcast (use ID from search)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search Apple Podcasts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and __fish_seen_subcommand_from help" -f -a "top" -d 'Top podcasts chart on Apple Podcasts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand apple-podcasts; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand arxiv; and not __fish_seen_subcommand_from paper search help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand arxiv; and not __fish_seen_subcommand_from paper search help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand arxiv; and not __fish_seen_subcommand_from paper search help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand arxiv; and not __fish_seen_subcommand_from paper search help" -f -a "paper" -d 'Get arXiv paper details by ID'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand arxiv; and not __fish_seen_subcommand_from paper search help" -f -a "search" -d 'Search arXiv papers'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand arxiv; and not __fish_seen_subcommand_from paper search help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand arxiv; and __fish_seen_subcommand_from paper" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand arxiv; and __fish_seen_subcommand_from paper" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand arxiv; and __fish_seen_subcommand_from paper" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand arxiv; and __fish_seen_subcommand_from search" -l limit -d 'Max results (max 25)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand arxiv; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand arxiv; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand arxiv; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand arxiv; and __fish_seen_subcommand_from help" -f -a "paper" -d 'Get arXiv paper details by ID'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand arxiv; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search arXiv papers'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand arxiv; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and not __fish_seen_subcommand_from flow greeks options quote help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and not __fish_seen_subcommand_from flow greeks options quote help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and not __fish_seen_subcommand_from flow greeks options quote help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and not __fish_seen_subcommand_from flow greeks options quote help" -f -a "flow" -d 'Barchart unusual options activity / options flow'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and not __fish_seen_subcommand_from flow greeks options quote help" -f -a "greeks" -d 'Barchart options greeks overview (IV, delta, gamma, theta, vega)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and not __fish_seen_subcommand_from flow greeks options quote help" -f -a "options" -d 'Barchart options chain with greeks, IV, volume, and open interest'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and not __fish_seen_subcommand_from flow greeks options quote help" -f -a "quote" -d 'Barchart stock quote with price, volume, and key metrics'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and not __fish_seen_subcommand_from flow greeks options quote help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from flow" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from flow" -l type -d 'Filter: all, call, or put' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from flow" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from flow" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from flow" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from greeks" -l expiration -d 'Expiration date (YYYY-MM-DD). Defaults to nearest available.' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from greeks" -l limit -d 'Number of near-the-money strikes per type' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from greeks" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from greeks" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from greeks" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from options" -l limit -d 'Max number of strikes to return' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from options" -l type -d 'Option type: Call or Put' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from options" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from options" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from options" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from quote" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from quote" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from quote" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from help" -f -a "flow" -d 'Barchart unusual options activity / options flow'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from help" -f -a "greeks" -d 'Barchart options greeks overview (IV, delta, gamma, theta, vega)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from help" -f -a "options" -d 'Barchart options chain with greeks, IV, volume, and open interest'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from help" -f -a "quote" -d 'Barchart stock quote with price, volume, and key metrics'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand barchart; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bbc; and not __fish_seen_subcommand_from news help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bbc; and not __fish_seen_subcommand_from news help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bbc; and not __fish_seen_subcommand_from news help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bbc; and not __fish_seen_subcommand_from news help" -f -a "news" -d 'BBC News headlines (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bbc; and not __fish_seen_subcommand_from news help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bbc; and __fish_seen_subcommand_from news" -l limit -d 'Number of headlines (max 50)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bbc; and __fish_seen_subcommand_from news" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bbc; and __fish_seen_subcommand_from news" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bbc; and __fish_seen_subcommand_from news" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bbc; and __fish_seen_subcommand_from help" -f -a "news" -d 'BBC News headlines (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bbc; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and not __fish_seen_subcommand_from download dynamic favorite feed following history hot me ranking search subtitle user-videos help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and not __fish_seen_subcommand_from download dynamic favorite feed following history hot me ranking search subtitle user-videos help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and not __fish_seen_subcommand_from download dynamic favorite feed following history hot me ranking search subtitle user-videos help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and not __fish_seen_subcommand_from download dynamic favorite feed following history hot me ranking search subtitle user-videos help" -f -a "download" -d '下载B站视频（需要 yt-dlp）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and not __fish_seen_subcommand_from download dynamic favorite feed following history hot me ranking search subtitle user-videos help" -f -a "dynamic" -d 'Get Bilibili user dynamic feed'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and not __fish_seen_subcommand_from download dynamic favorite feed following history hot me ranking search subtitle user-videos help" -f -a "favorite" -d '我的默认收藏夹'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and not __fish_seen_subcommand_from download dynamic favorite feed following history hot me ranking search subtitle user-videos help" -f -a "feed" -d '关注的人的动态时间线'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and not __fish_seen_subcommand_from download dynamic favorite feed following history hot me ranking search subtitle user-videos help" -f -a "following" -d '获取 Bilibili 用户的关注列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and not __fish_seen_subcommand_from download dynamic favorite feed following history hot me ranking search subtitle user-videos help" -f -a "history" -d '我的观看历史'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and not __fish_seen_subcommand_from download dynamic favorite feed following history hot me ranking search subtitle user-videos help" -f -a "hot" -d 'B站热门视频'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and not __fish_seen_subcommand_from download dynamic favorite feed following history hot me ranking search subtitle user-videos help" -f -a "me" -d 'My Bilibili profile info'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and not __fish_seen_subcommand_from download dynamic favorite feed following history hot me ranking search subtitle user-videos help" -f -a "ranking" -d 'Get Bilibili video ranking board'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and not __fish_seen_subcommand_from download dynamic favorite feed following history hot me ranking search subtitle user-videos help" -f -a "search" -d 'Search Bilibili videos or users'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and not __fish_seen_subcommand_from download dynamic favorite feed following history hot me ranking search subtitle user-videos help" -f -a "subtitle" -d '获取 Bilibili 视频的字幕'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and not __fish_seen_subcommand_from download dynamic favorite feed following history hot me ranking search subtitle user-videos help" -f -a "user-videos" -d '查看指定用户的投稿视频'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and not __fish_seen_subcommand_from download dynamic favorite feed following history hot me ranking search subtitle user-videos help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from download" -l output -d 'Output directory' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from download" -l quality -d 'Video quality (best, 1080p, 720p, 480p)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from download" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from download" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from download" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from dynamic" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from dynamic" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from dynamic" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from dynamic" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from favorite" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from favorite" -l page -d 'Page number' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from favorite" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from favorite" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from favorite" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from feed" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from feed" -l type -d 'Filter: all, video, article' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from feed" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from feed" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from feed" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from following" -l limit -d '每页数量 (最大 50)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from following" -l page -d '页码' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from following" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from following" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from following" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from history" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from history" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from history" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from history" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from hot" -l limit -d 'Number of videos' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from hot" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from hot" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from hot" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from me" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from me" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from me" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from ranking" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from ranking" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from ranking" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from ranking" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from search" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from search" -l page -d 'Result page' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from search" -l type -d 'video or user' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from subtitle" -l lang -d '字幕语言代码 (如 zh-CN, en-US, ai-zh)，默认取第一个' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from subtitle" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from subtitle" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from subtitle" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from user-videos" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from user-videos" -l order -d 'Sort: pubdate, click, stow' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from user-videos" -l page -d 'Page number' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from user-videos" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from user-videos" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from user-videos" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from help" -f -a "download" -d '下载B站视频（需要 yt-dlp）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from help" -f -a "dynamic" -d 'Get Bilibili user dynamic feed'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from help" -f -a "favorite" -d '我的默认收藏夹'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from help" -f -a "feed" -d '关注的人的动态时间线'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from help" -f -a "following" -d '获取 Bilibili 用户的关注列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from help" -f -a "history" -d '我的观看历史'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from help" -f -a "hot" -d 'B站热门视频'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from help" -f -a "me" -d 'My Bilibili profile info'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from help" -f -a "ranking" -d 'Get Bilibili video ranking board'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search Bilibili videos or users'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from help" -f -a "subtitle" -d '获取 Bilibili 视频的字幕'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from help" -f -a "user-videos" -d '查看指定用户的投稿视频'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bilibili; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and not __fish_seen_subcommand_from businessweek economics feeds industries main markets news opinions politics tech help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and not __fish_seen_subcommand_from businessweek economics feeds industries main markets news opinions politics tech help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and not __fish_seen_subcommand_from businessweek economics feeds industries main markets news opinions politics tech help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and not __fish_seen_subcommand_from businessweek economics feeds industries main markets news opinions politics tech help" -f -a "businessweek" -d 'Bloomberg Businessweek top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and not __fish_seen_subcommand_from businessweek economics feeds industries main markets news opinions politics tech help" -f -a "economics" -d 'Bloomberg Economics top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and not __fish_seen_subcommand_from businessweek economics feeds industries main markets news opinions politics tech help" -f -a "feeds" -d 'List the Bloomberg RSS feed aliases used by the adapter'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and not __fish_seen_subcommand_from businessweek economics feeds industries main markets news opinions politics tech help" -f -a "industries" -d 'Bloomberg Industries top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and not __fish_seen_subcommand_from businessweek economics feeds industries main markets news opinions politics tech help" -f -a "main" -d 'Bloomberg homepage top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and not __fish_seen_subcommand_from businessweek economics feeds industries main markets news opinions politics tech help" -f -a "markets" -d 'Bloomberg Markets top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and not __fish_seen_subcommand_from businessweek economics feeds industries main markets news opinions politics tech help" -f -a "news" -d 'Read a Bloomberg story/article page and return title, full content, and media links'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and not __fish_seen_subcommand_from businessweek economics feeds industries main markets news opinions politics tech help" -f -a "opinions" -d 'Bloomberg Opinion top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and not __fish_seen_subcommand_from businessweek economics feeds industries main markets news opinions politics tech help" -f -a "politics" -d 'Bloomberg Politics top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and not __fish_seen_subcommand_from businessweek economics feeds industries main markets news opinions politics tech help" -f -a "tech" -d 'Bloomberg Tech top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and not __fish_seen_subcommand_from businessweek economics feeds industries main markets news opinions politics tech help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from businessweek" -l limit -d 'Number of feed items to return (max 20)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from businessweek" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from businessweek" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from businessweek" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from economics" -l limit -d 'Number of feed items to return (max 20)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from economics" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from economics" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from economics" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from feeds" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from feeds" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from feeds" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from industries" -l limit -d 'Number of feed items to return (max 20)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from industries" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from industries" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from industries" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from main" -l limit -d 'Number of feed items to return (max 20)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from main" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from main" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from main" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from markets" -l limit -d 'Number of feed items to return (max 20)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from markets" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from markets" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from markets" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from news" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from news" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from news" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from opinions" -l limit -d 'Number of feed items to return (max 20)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from opinions" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from opinions" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from opinions" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from politics" -l limit -d 'Number of feed items to return (max 20)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from politics" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from politics" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from politics" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from tech" -l limit -d 'Number of feed items to return (max 20)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from tech" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from tech" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from tech" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from help" -f -a "businessweek" -d 'Bloomberg Businessweek top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from help" -f -a "economics" -d 'Bloomberg Economics top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from help" -f -a "feeds" -d 'List the Bloomberg RSS feed aliases used by the adapter'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from help" -f -a "industries" -d 'Bloomberg Industries top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from help" -f -a "main" -d 'Bloomberg homepage top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from help" -f -a "markets" -d 'Bloomberg Markets top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from help" -f -a "news" -d 'Read a Bloomberg story/article page and return title, full content, and media links'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from help" -f -a "opinions" -d 'Bloomberg Opinion top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from help" -f -a "politics" -d 'Bloomberg Politics top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from help" -f -a "tech" -d 'Bloomberg Tech top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand bloomberg; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and not __fish_seen_subcommand_from batchgreet chatlist chatmsg detail exchange greet invite joblist mark recommend resume search send stats help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and not __fish_seen_subcommand_from batchgreet chatlist chatmsg detail exchange greet invite joblist mark recommend resume search send stats help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and not __fish_seen_subcommand_from batchgreet chatlist chatmsg detail exchange greet invite joblist mark recommend resume search send stats help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and not __fish_seen_subcommand_from batchgreet chatlist chatmsg detail exchange greet invite joblist mark recommend resume search send stats help" -f -a "batchgreet" -d 'BOSS直聘批量向推荐候选人发送招呼'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and not __fish_seen_subcommand_from batchgreet chatlist chatmsg detail exchange greet invite joblist mark recommend resume search send stats help" -f -a "chatlist" -d 'BOSS直聘查看聊天列表（招聘端）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and not __fish_seen_subcommand_from batchgreet chatlist chatmsg detail exchange greet invite joblist mark recommend resume search send stats help" -f -a "chatmsg" -d 'BOSS直聘查看与候选人的聊天消息'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and not __fish_seen_subcommand_from batchgreet chatlist chatmsg detail exchange greet invite joblist mark recommend resume search send stats help" -f -a "detail" -d 'BOSS直聘查看职位详情'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and not __fish_seen_subcommand_from batchgreet chatlist chatmsg detail exchange greet invite joblist mark recommend resume search send stats help" -f -a "exchange" -d 'BOSS直聘交换联系方式（请求手机/微信）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and not __fish_seen_subcommand_from batchgreet chatlist chatmsg detail exchange greet invite joblist mark recommend resume search send stats help" -f -a "greet" -d 'BOSS直聘向新候选人发送招呼（开始聊天）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and not __fish_seen_subcommand_from batchgreet chatlist chatmsg detail exchange greet invite joblist mark recommend resume search send stats help" -f -a "invite" -d 'BOSS直聘发送面试邀请'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and not __fish_seen_subcommand_from batchgreet chatlist chatmsg detail exchange greet invite joblist mark recommend resume search send stats help" -f -a "joblist" -d 'BOSS直聘查看我发布的职位列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and not __fish_seen_subcommand_from batchgreet chatlist chatmsg detail exchange greet invite joblist mark recommend resume search send stats help" -f -a "mark" -d 'BOSS直聘给候选人添加标签'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and not __fish_seen_subcommand_from batchgreet chatlist chatmsg detail exchange greet invite joblist mark recommend resume search send stats help" -f -a "recommend" -d 'BOSS直聘查看推荐候选人（新招呼列表）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and not __fish_seen_subcommand_from batchgreet chatlist chatmsg detail exchange greet invite joblist mark recommend resume search send stats help" -f -a "resume" -d 'BOSS直聘查看候选人简历（招聘端）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and not __fish_seen_subcommand_from batchgreet chatlist chatmsg detail exchange greet invite joblist mark recommend resume search send stats help" -f -a "search" -d 'BOSS直聘搜索职位'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and not __fish_seen_subcommand_from batchgreet chatlist chatmsg detail exchange greet invite joblist mark recommend resume search send stats help" -f -a "send" -d 'BOSS直聘发送聊天消息'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and not __fish_seen_subcommand_from batchgreet chatlist chatmsg detail exchange greet invite joblist mark recommend resume search send stats help" -f -a "stats" -d 'BOSS直聘职位数据统计'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and not __fish_seen_subcommand_from batchgreet chatlist chatmsg detail exchange greet invite joblist mark recommend resume search send stats help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from batchgreet" -l job-id -d 'Filter by encrypted job ID (greet all jobs if empty)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from batchgreet" -l limit -d 'Max candidates to greet' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from batchgreet" -l text -d 'Custom greeting message (uses default if empty)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from batchgreet" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from batchgreet" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from batchgreet" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from chatlist" -l job-id -d 'Filter by job ID (0=all)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from chatlist" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from chatlist" -l page -d 'Page number' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from chatlist" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from chatlist" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from chatlist" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from chatmsg" -l page -d 'Page number' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from chatmsg" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from chatmsg" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from chatmsg" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from detail" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from detail" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from detail" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from exchange" -l type -d 'Exchange type: phone or wechat' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from exchange" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from exchange" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from exchange" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from greet" -l job-id -d 'Encrypted job ID' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from greet" -l security-id -d 'Security ID of the candidate' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from greet" -l text -d 'Custom greeting message' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from greet" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from greet" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from greet" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from invite" -l address -d 'Interview address' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from invite" -l contact -d 'Contact person name' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from invite" -l time -d 'Interview time (e.g. 2025-04-01 14:00)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from invite" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from invite" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from invite" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from joblist" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from joblist" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from joblist" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from mark" -l label -d 'Label name or ID' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from mark" -l remove -d 'Remove the label instead of adding' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from mark" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from mark" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from mark" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from recommend" -l limit -d 'Number of results to return' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from recommend" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from recommend" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from recommend" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from resume" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from resume" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from resume" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from search" -l city -d 'City name or code' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from search" -l degree -d 'Degree filter' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from search" -l experience -d 'Experience filter' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from search" -l industry -d 'Industry code or name' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from search" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from search" -l page -d 'Page number' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from search" -l salary -d 'Salary filter' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from send" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from send" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from send" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from stats" -l job-id -d 'Encrypted job ID (show all if empty)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from stats" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from stats" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from stats" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from help" -f -a "batchgreet" -d 'BOSS直聘批量向推荐候选人发送招呼'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from help" -f -a "chatlist" -d 'BOSS直聘查看聊天列表（招聘端）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from help" -f -a "chatmsg" -d 'BOSS直聘查看与候选人的聊天消息'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from help" -f -a "detail" -d 'BOSS直聘查看职位详情'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from help" -f -a "exchange" -d 'BOSS直聘交换联系方式（请求手机/微信）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from help" -f -a "greet" -d 'BOSS直聘向新候选人发送招呼（开始聊天）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from help" -f -a "invite" -d 'BOSS直聘发送面试邀请'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from help" -f -a "joblist" -d 'BOSS直聘查看我发布的职位列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from help" -f -a "mark" -d 'BOSS直聘给候选人添加标签'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from help" -f -a "recommend" -d 'BOSS直聘查看推荐候选人（新招呼列表）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from help" -f -a "resume" -d 'BOSS直聘查看候选人简历（招聘端）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from help" -f -a "search" -d 'BOSS直聘搜索职位'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from help" -f -a "send" -d 'BOSS直聘发送聊天消息'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from help" -f -a "stats" -d 'BOSS直聘职位数据统计'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand boss; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and not __fish_seen_subcommand_from assignments exams help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and not __fish_seen_subcommand_from assignments exams help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and not __fish_seen_subcommand_from assignments exams help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and not __fish_seen_subcommand_from assignments exams help" -f -a "assignments" -d '学习通作业列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and not __fish_seen_subcommand_from assignments exams help" -f -a "exams" -d '学习通考试列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and not __fish_seen_subcommand_from assignments exams help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and __fish_seen_subcommand_from assignments" -l course -d '按课程名过滤（模糊匹配）' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and __fish_seen_subcommand_from assignments" -l limit -d '最大返回数量' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and __fish_seen_subcommand_from assignments" -l status -d '按状态过滤' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and __fish_seen_subcommand_from assignments" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and __fish_seen_subcommand_from assignments" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and __fish_seen_subcommand_from assignments" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and __fish_seen_subcommand_from exams" -l course -d '按课程名过滤（模糊匹配）' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and __fish_seen_subcommand_from exams" -l limit -d '最大返回数量' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and __fish_seen_subcommand_from exams" -l status -d '按状态过滤' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and __fish_seen_subcommand_from exams" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and __fish_seen_subcommand_from exams" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and __fish_seen_subcommand_from exams" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and __fish_seen_subcommand_from help" -f -a "assignments" -d '学习通作业列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and __fish_seen_subcommand_from help" -f -a "exams" -d '学习通考试列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chaoxing; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and not __fish_seen_subcommand_from ask ax new read send status help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and not __fish_seen_subcommand_from ask ax new read send status help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and not __fish_seen_subcommand_from ask ax new read send status help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and not __fish_seen_subcommand_from ask ax new read send status help" -f -a "ask" -d 'Send a prompt and wait for the AI response (macOS ChatGPT desktop app)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and not __fish_seen_subcommand_from ask ax new read send status help" -f -a "ax" -d 'Read visible chat messages from ChatGPT Desktop via macOS Accessibility API'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and not __fish_seen_subcommand_from ask ax new read send status help" -f -a "new" -d 'Open a new chat in ChatGPT Desktop App'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and not __fish_seen_subcommand_from ask ax new read send status help" -f -a "read" -d 'Read the last visible message from the focused ChatGPT Desktop window'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and not __fish_seen_subcommand_from ask ax new read send status help" -f -a "send" -d 'Send a message to the active ChatGPT Desktop App window'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and not __fish_seen_subcommand_from ask ax new read send status help" -f -a "status" -d 'Check if ChatGPT Desktop App is running natively on macOS'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and not __fish_seen_subcommand_from ask ax new read send status help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from ask" -l timeout -d 'Max seconds to wait for response' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from ask" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from ask" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from ask" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from ax" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from ax" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from ax" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from new" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from new" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from new" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from read" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from read" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from read" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from send" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from send" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from send" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from status" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from status" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from status" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from help" -f -a "ask" -d 'Send a prompt and wait for the AI response (macOS ChatGPT desktop app)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from help" -f -a "ax" -d 'Read visible chat messages from ChatGPT Desktop via macOS Accessibility API'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from help" -f -a "new" -d 'Open a new chat in ChatGPT Desktop App'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from help" -f -a "read" -d 'Read the last visible message from the focused ChatGPT Desktop window'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from help" -f -a "send" -d 'Send a message to the active ChatGPT Desktop App window'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from help" -f -a "status" -d 'Check if ChatGPT Desktop App is running natively on macOS'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatgpt; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and not __fish_seen_subcommand_from ask export history model new read screenshot send status help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and not __fish_seen_subcommand_from ask export history model new read screenshot send status help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and not __fish_seen_subcommand_from ask export history model new read screenshot send status help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and not __fish_seen_subcommand_from ask export history model new read screenshot send status help" -f -a "ask" -d 'Send a prompt and wait for the AI response (send + wait + read)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and not __fish_seen_subcommand_from ask export history model new read screenshot send status help" -f -a "export" -d 'Export the current ChatWise conversation to a Markdown file'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and not __fish_seen_subcommand_from ask export history model new read screenshot send status help" -f -a "history" -d 'List conversation history in ChatWise sidebar'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and not __fish_seen_subcommand_from ask export history model new read screenshot send status help" -f -a "model" -d 'Get or switch the active AI model in ChatWise'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and not __fish_seen_subcommand_from ask export history model new read screenshot send status help" -f -a "new" -d 'Start a new conversation in ChatWise'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and not __fish_seen_subcommand_from ask export history model new read screenshot send status help" -f -a "read" -d 'Read the current ChatWise conversation history'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and not __fish_seen_subcommand_from ask export history model new read screenshot send status help" -f -a "screenshot" -d 'Capture a snapshot of the current ChatWise window (DOM + Accessibility tree)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and not __fish_seen_subcommand_from ask export history model new read screenshot send status help" -f -a "send" -d 'Send a message to the active ChatWise conversation'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and not __fish_seen_subcommand_from ask export history model new read screenshot send status help" -f -a "status" -d 'Check active CDP connection to ChatWise Desktop'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and not __fish_seen_subcommand_from ask export history model new read screenshot send status help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from ask" -l timeout -d 'Max seconds to wait' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from ask" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from ask" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from ask" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from export" -l output -d 'Output file (default: /tmp/chatwise-export.md)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from export" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from export" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from export" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from history" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from history" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from history" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from model" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from model" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from model" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from new" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from new" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from new" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from read" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from read" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from read" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from screenshot" -l output -d 'Output file path (default: /tmp/chatwise-snapshot)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from screenshot" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from screenshot" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from screenshot" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from send" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from send" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from send" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from status" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from status" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from status" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from help" -f -a "ask" -d 'Send a prompt and wait for the AI response (send + wait + read)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from help" -f -a "export" -d 'Export the current ChatWise conversation to a Markdown file'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from help" -f -a "history" -d 'List conversation history in ChatWise sidebar'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from help" -f -a "model" -d 'Get or switch the active AI model in ChatWise'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from help" -f -a "new" -d 'Start a new conversation in ChatWise'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from help" -f -a "read" -d 'Read the current ChatWise conversation history'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from help" -f -a "screenshot" -d 'Capture a snapshot of the current ChatWise window (DOM + Accessibility tree)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from help" -f -a "send" -d 'Send a message to the active ChatWise conversation'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from help" -f -a "status" -d 'Check active CDP connection to ChatWise Desktop'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand chatwise; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and not __fish_seen_subcommand_from ask dump export extract-diff history model new read screenshot send status help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and not __fish_seen_subcommand_from ask dump export extract-diff history model new read screenshot send status help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and not __fish_seen_subcommand_from ask dump export extract-diff history model new read screenshot send status help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and not __fish_seen_subcommand_from ask dump export extract-diff history model new read screenshot send status help" -f -a "ask" -d 'Send a prompt and wait for the AI response (send + wait + read)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and not __fish_seen_subcommand_from ask dump export extract-diff history model new read screenshot send status help" -f -a "dump" -d 'Dump the DOM and Accessibility tree of Codex for reverse-engineering'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and not __fish_seen_subcommand_from ask dump export extract-diff history model new read screenshot send status help" -f -a "export" -d 'Export the current Codex conversation to a Markdown file'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and not __fish_seen_subcommand_from ask dump export extract-diff history model new read screenshot send status help" -f -a "extract-diff" -d 'Extract visual code review diff patches from Codex'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and not __fish_seen_subcommand_from ask dump export extract-diff history model new read screenshot send status help" -f -a "history" -d 'List recent conversation threads in Codex'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and not __fish_seen_subcommand_from ask dump export extract-diff history model new read screenshot send status help" -f -a "model" -d 'Get or switch the currently active AI model in Codex Desktop'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and not __fish_seen_subcommand_from ask dump export extract-diff history model new read screenshot send status help" -f -a "new" -d 'Start a new Codex conversation thread / isolated workspace'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and not __fish_seen_subcommand_from ask dump export extract-diff history model new read screenshot send status help" -f -a "read" -d 'Read the contents of the current Codex conversation thread'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and not __fish_seen_subcommand_from ask dump export extract-diff history model new read screenshot send status help" -f -a "screenshot" -d 'Capture a snapshot of the current Codex window (DOM + Accessibility tree)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and not __fish_seen_subcommand_from ask dump export extract-diff history model new read screenshot send status help" -f -a "send" -d 'Send text/commands to the Codex AI composer'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and not __fish_seen_subcommand_from ask dump export extract-diff history model new read screenshot send status help" -f -a "status" -d 'Check active CDP connection to OpenAI Codex App'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and not __fish_seen_subcommand_from ask dump export extract-diff history model new read screenshot send status help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from ask" -l timeout -d 'Max seconds to wait for response' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from ask" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from ask" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from ask" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from dump" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from dump" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from dump" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from export" -l output -d 'Output file (default: /tmp/codex-export.md)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from export" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from export" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from export" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from extract-diff" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from extract-diff" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from extract-diff" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from history" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from history" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from history" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from model" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from model" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from model" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from new" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from new" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from new" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from read" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from read" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from read" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from screenshot" -l output -d 'Output file path (default: /tmp/codex-snapshot.txt)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from screenshot" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from screenshot" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from screenshot" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from send" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from send" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from send" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from status" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from status" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from status" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from help" -f -a "ask" -d 'Send a prompt and wait for the AI response (send + wait + read)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from help" -f -a "dump" -d 'Dump the DOM and Accessibility tree of Codex for reverse-engineering'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from help" -f -a "export" -d 'Export the current Codex conversation to a Markdown file'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from help" -f -a "extract-diff" -d 'Extract visual code review diff patches from Codex'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from help" -f -a "history" -d 'List recent conversation threads in Codex'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from help" -f -a "model" -d 'Get or switch the currently active AI model in Codex Desktop'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from help" -f -a "new" -d 'Start a new Codex conversation thread / isolated workspace'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from help" -f -a "read" -d 'Read the contents of the current Codex conversation thread'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from help" -f -a "screenshot" -d 'Capture a snapshot of the current Codex window (DOM + Accessibility tree)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from help" -f -a "send" -d 'Send text/commands to the Codex AI composer'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from help" -f -a "status" -d 'Check active CDP connection to OpenAI Codex App'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand codex; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and not __fish_seen_subcommand_from add-to-cart search help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and not __fish_seen_subcommand_from add-to-cart search help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and not __fish_seen_subcommand_from add-to-cart search help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and not __fish_seen_subcommand_from add-to-cart search help" -f -a "add-to-cart" -d 'Add a Coupang product to cart using logged-in browser session'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and not __fish_seen_subcommand_from add-to-cart search help" -f -a "search" -d 'Search Coupang products with logged-in browser session'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and not __fish_seen_subcommand_from add-to-cart search help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and __fish_seen_subcommand_from add-to-cart" -l url -d 'Canonical product URL' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and __fish_seen_subcommand_from add-to-cart" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and __fish_seen_subcommand_from add-to-cart" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and __fish_seen_subcommand_from add-to-cart" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and __fish_seen_subcommand_from search" -l filter -d 'Optional search filter (currently supports: rocket)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and __fish_seen_subcommand_from search" -l limit -d 'Max results (max 50)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and __fish_seen_subcommand_from search" -l page -d 'Search result page number' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and __fish_seen_subcommand_from help" -f -a "add-to-cart" -d 'Add a Coupang product to cart using logged-in browser session'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search Coupang products with logged-in browser session'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand coupang; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand ctrip; and not __fish_seen_subcommand_from search help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand ctrip; and not __fish_seen_subcommand_from search help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand ctrip; and not __fish_seen_subcommand_from search help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand ctrip; and not __fish_seen_subcommand_from search help" -f -a "search" -d '携程旅行搜索'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand ctrip; and not __fish_seen_subcommand_from search help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand ctrip; and __fish_seen_subcommand_from search" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand ctrip; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand ctrip; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand ctrip; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand ctrip; and __fish_seen_subcommand_from help" -f -a "search" -d '携程旅行搜索'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand ctrip; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and not __fish_seen_subcommand_from ask composer dump export extract-code history model new read screenshot send status help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and not __fish_seen_subcommand_from ask composer dump export extract-code history model new read screenshot send status help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and not __fish_seen_subcommand_from ask composer dump export extract-code history model new read screenshot send status help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and not __fish_seen_subcommand_from ask composer dump export extract-code history model new read screenshot send status help" -f -a "ask" -d 'Send a prompt and wait for the AI response (send + wait + read)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and not __fish_seen_subcommand_from ask composer dump export extract-code history model new read screenshot send status help" -f -a "composer" -d 'Send a prompt directly into Cursor Composer (Cmd+I shortcut)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and not __fish_seen_subcommand_from ask composer dump export extract-code history model new read screenshot send status help" -f -a "dump" -d 'Dump the DOM and Accessibility tree of Cursor for reverse-engineering'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and not __fish_seen_subcommand_from ask composer dump export extract-code history model new read screenshot send status help" -f -a "export" -d 'Export the current Cursor conversation to Markdown'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and not __fish_seen_subcommand_from ask composer dump export extract-code history model new read screenshot send status help" -f -a "extract-code" -d 'Extract multi-line code blocks from the current Cursor conversation'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and not __fish_seen_subcommand_from ask composer dump export extract-code history model new read screenshot send status help" -f -a "history" -d 'List recent chat sessions from the Cursor sidebar'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and not __fish_seen_subcommand_from ask composer dump export extract-code history model new read screenshot send status help" -f -a "model" -d 'Get or switch the currently active AI model in Cursor'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and not __fish_seen_subcommand_from ask composer dump export extract-code history model new read screenshot send status help" -f -a "new" -d 'Start a new Cursor chat or Composer session'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and not __fish_seen_subcommand_from ask composer dump export extract-code history model new read screenshot send status help" -f -a "read" -d 'Read the current Cursor chat/composer conversation history'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and not __fish_seen_subcommand_from ask composer dump export extract-code history model new read screenshot send status help" -f -a "screenshot" -d 'Capture a snapshot of the current Cursor window (DOM + Accessibility tree)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and not __fish_seen_subcommand_from ask composer dump export extract-code history model new read screenshot send status help" -f -a "send" -d 'Send a prompt directly into Cursor Composer/Chat'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and not __fish_seen_subcommand_from ask composer dump export extract-code history model new read screenshot send status help" -f -a "status" -d 'Check active CDP connection to Cursor AI Editor'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and not __fish_seen_subcommand_from ask composer dump export extract-code history model new read screenshot send status help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from ask" -l timeout -d 'Max seconds to wait for response' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from ask" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from ask" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from ask" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from composer" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from composer" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from composer" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from dump" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from dump" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from dump" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from export" -l output -d 'Output file (default: /tmp/cursor-export.md)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from export" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from export" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from export" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from extract-code" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from extract-code" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from extract-code" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from history" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from history" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from history" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from model" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from model" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from model" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from new" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from new" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from new" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from read" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from read" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from read" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from screenshot" -l output -d 'Output file path (default: /tmp/cursor-snapshot.txt)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from screenshot" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from screenshot" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from screenshot" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from send" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from send" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from send" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from status" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from status" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from status" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from help" -f -a "ask" -d 'Send a prompt and wait for the AI response (send + wait + read)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from help" -f -a "composer" -d 'Send a prompt directly into Cursor Composer (Cmd+I shortcut)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from help" -f -a "dump" -d 'Dump the DOM and Accessibility tree of Cursor for reverse-engineering'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from help" -f -a "export" -d 'Export the current Cursor conversation to Markdown'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from help" -f -a "extract-code" -d 'Extract multi-line code blocks from the current Cursor conversation'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from help" -f -a "history" -d 'List recent chat sessions from the Cursor sidebar'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from help" -f -a "model" -d 'Get or switch the currently active AI model in Cursor'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from help" -f -a "new" -d 'Start a new Cursor chat or Composer session'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from help" -f -a "read" -d 'Read the current Cursor chat/composer conversation history'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from help" -f -a "screenshot" -d 'Capture a snapshot of the current Cursor window (DOM + Accessibility tree)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from help" -f -a "send" -d 'Send a prompt directly into Cursor Composer/Chat'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from help" -f -a "status" -d 'Check active CDP connection to Cursor AI Editor'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cursor; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and not __fish_seen_subcommand_from tag top user help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and not __fish_seen_subcommand_from tag top user help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and not __fish_seen_subcommand_from tag top user help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and not __fish_seen_subcommand_from tag top user help" -f -a "tag" -d 'Latest DEV.to articles for a specific tag'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and not __fish_seen_subcommand_from tag top user help" -f -a "top" -d 'Top DEV.to articles of the day'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and not __fish_seen_subcommand_from tag top user help" -f -a "user" -d 'Recent DEV.to articles from a specific user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and not __fish_seen_subcommand_from tag top user help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and __fish_seen_subcommand_from tag" -l limit -d 'Number of articles' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and __fish_seen_subcommand_from tag" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and __fish_seen_subcommand_from tag" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and __fish_seen_subcommand_from tag" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and __fish_seen_subcommand_from top" -l limit -d 'Number of articles' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and __fish_seen_subcommand_from top" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and __fish_seen_subcommand_from top" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and __fish_seen_subcommand_from top" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and __fish_seen_subcommand_from user" -l limit -d 'Number of articles' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and __fish_seen_subcommand_from user" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and __fish_seen_subcommand_from user" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and __fish_seen_subcommand_from user" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and __fish_seen_subcommand_from help" -f -a "tag" -d 'Latest DEV.to articles for a specific tag'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and __fish_seen_subcommand_from help" -f -a "top" -d 'Top DEV.to articles of the day'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and __fish_seen_subcommand_from help" -f -a "user" -d 'Recent DEV.to articles from a specific user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand devto; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and not __fish_seen_subcommand_from channels members read search send servers status help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and not __fish_seen_subcommand_from channels members read search send servers status help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and not __fish_seen_subcommand_from channels members read search send servers status help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and not __fish_seen_subcommand_from channels members read search send servers status help" -f -a "channels" -d 'List channels in the current Discord server'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and not __fish_seen_subcommand_from channels members read search send servers status help" -f -a "members" -d 'List online members in the current Discord channel'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and not __fish_seen_subcommand_from channels members read search send servers status help" -f -a "read" -d 'Read recent messages from the active Discord channel'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and not __fish_seen_subcommand_from channels members read search send servers status help" -f -a "search" -d 'Search messages in the current Discord server/channel'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and not __fish_seen_subcommand_from channels members read search send servers status help" -f -a "send" -d 'Send a message in the active Discord channel'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and not __fish_seen_subcommand_from channels members read search send servers status help" -f -a "servers" -d 'List all Discord servers (guilds) in the sidebar'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and not __fish_seen_subcommand_from channels members read search send servers status help" -f -a "status" -d 'Check active CDP connection to Discord Desktop'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and not __fish_seen_subcommand_from channels members read search send servers status help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from channels" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from channels" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from channels" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from members" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from members" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from members" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from read" -l count -d 'Number of messages to read' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from read" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from read" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from read" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from send" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from send" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from send" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from servers" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from servers" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from servers" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from status" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from status" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from status" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from help" -f -a "channels" -d 'List channels in the current Discord server'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from help" -f -a "members" -d 'List online members in the current Discord channel'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from help" -f -a "read" -d 'Read recent messages from the active Discord channel'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search messages in the current Discord server/channel'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from help" -f -a "send" -d 'Send a message in the active Discord channel'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from help" -f -a "servers" -d 'List all Discord servers (guilds) in the sidebar'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from help" -f -a "status" -d 'Check active CDP connection to Discord Desktop'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand discord-app; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and not __fish_seen_subcommand_from book-hot marks movie-hot reviews search subject top250 help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and not __fish_seen_subcommand_from book-hot marks movie-hot reviews search subject top250 help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and not __fish_seen_subcommand_from book-hot marks movie-hot reviews search subject top250 help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and not __fish_seen_subcommand_from book-hot marks movie-hot reviews search subject top250 help" -f -a "book-hot" -d '豆瓣图书热门榜单'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and not __fish_seen_subcommand_from book-hot marks movie-hot reviews search subject top250 help" -f -a "marks" -d '导出个人观影标记'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and not __fish_seen_subcommand_from book-hot marks movie-hot reviews search subject top250 help" -f -a "movie-hot" -d '豆瓣电影热门榜单'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and not __fish_seen_subcommand_from book-hot marks movie-hot reviews search subject top250 help" -f -a "reviews" -d '导出个人影评'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and not __fish_seen_subcommand_from book-hot marks movie-hot reviews search subject top250 help" -f -a "search" -d '搜索豆瓣电影、图书或音乐'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and not __fish_seen_subcommand_from book-hot marks movie-hot reviews search subject top250 help" -f -a "subject" -d '获取电影详情'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and not __fish_seen_subcommand_from book-hot marks movie-hot reviews search subject top250 help" -f -a "top250" -d '豆瓣电影 Top250'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and not __fish_seen_subcommand_from book-hot marks movie-hot reviews search subject top250 help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from book-hot" -l limit -d '返回的图书数量' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from book-hot" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from book-hot" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from book-hot" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from marks" -l limit -d '导出数量，0 表示全部' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from marks" -l status -d '标记类型: collect(看过), wish(想看), do(在看), all(全部)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from marks" -l uid -d '用户ID，不填则使用当前登录账号' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from marks" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from marks" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from marks" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from movie-hot" -l limit -d '返回的电影数量' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from movie-hot" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from movie-hot" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from movie-hot" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from reviews" -l full -d '获取完整影评内容' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from reviews" -l limit -d '导出数量' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from reviews" -l uid -d '用户ID，不填则使用当前登录账号' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from reviews" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from reviews" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from reviews" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from search" -l limit -d '返回结果数量' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from search" -l type -d '搜索类型（movie=电影, book=图书, music=音乐）' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from subject" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from subject" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from subject" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from top250" -l limit -d '返回结果数量' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from top250" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from top250" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from top250" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from help" -f -a "book-hot" -d '豆瓣图书热门榜单'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from help" -f -a "marks" -d '导出个人观影标记'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from help" -f -a "movie-hot" -d '豆瓣电影热门榜单'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from help" -f -a "reviews" -d '导出个人影评'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from help" -f -a "search" -d '搜索豆瓣电影、图书或音乐'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from help" -f -a "subject" -d '获取电影详情'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from help" -f -a "top250" -d '豆瓣电影 Top250'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand douban; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and not __fish_seen_subcommand_from ask new read send status help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and not __fish_seen_subcommand_from ask new read send status help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and not __fish_seen_subcommand_from ask new read send status help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and not __fish_seen_subcommand_from ask new read send status help" -f -a "ask" -d 'Send a prompt and wait for the Doubao response'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and not __fish_seen_subcommand_from ask new read send status help" -f -a "new" -d 'Start a new conversation in Doubao web chat'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and not __fish_seen_subcommand_from ask new read send status help" -f -a "read" -d 'Read the current Doubao conversation history'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and not __fish_seen_subcommand_from ask new read send status help" -f -a "send" -d 'Send a message to Doubao web chat'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and not __fish_seen_subcommand_from ask new read send status help" -f -a "status" -d 'Check Doubao chat page availability and login state'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and not __fish_seen_subcommand_from ask new read send status help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from ask" -l timeout -d 'Max seconds to wait' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from ask" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from ask" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from ask" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from new" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from new" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from new" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from read" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from read" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from read" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from send" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from send" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from send" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from status" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from status" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from status" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from help" -f -a "ask" -d 'Send a prompt and wait for the Doubao response'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from help" -f -a "new" -d 'Start a new conversation in Doubao web chat'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from help" -f -a "read" -d 'Read the current Doubao conversation history'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from help" -f -a "send" -d 'Send a message to Doubao web chat'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from help" -f -a "status" -d 'Check Doubao chat page availability and login state'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and not __fish_seen_subcommand_from ask dump new read screenshot send status help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and not __fish_seen_subcommand_from ask dump new read screenshot send status help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and not __fish_seen_subcommand_from ask dump new read screenshot send status help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and not __fish_seen_subcommand_from ask dump new read screenshot send status help" -f -a "ask" -d 'Send a message to Doubao desktop app and wait for the AI response'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and not __fish_seen_subcommand_from ask dump new read screenshot send status help" -f -a "dump" -d 'Dump Doubao desktop app DOM and snapshot to /tmp for debugging'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and not __fish_seen_subcommand_from ask dump new read screenshot send status help" -f -a "new" -d 'Start a new chat in Doubao desktop app'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and not __fish_seen_subcommand_from ask dump new read screenshot send status help" -f -a "read" -d 'Read chat history from Doubao desktop app'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and not __fish_seen_subcommand_from ask dump new read screenshot send status help" -f -a "screenshot" -d 'Capture a screenshot of the Doubao desktop app window'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and not __fish_seen_subcommand_from ask dump new read screenshot send status help" -f -a "send" -d 'Send a message to Doubao desktop app'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and not __fish_seen_subcommand_from ask dump new read screenshot send status help" -f -a "status" -d 'Check CDP connection to Doubao desktop app'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and not __fish_seen_subcommand_from ask dump new read screenshot send status help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from ask" -l timeout -d 'Max seconds to wait for response' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from ask" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from ask" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from ask" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from dump" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from dump" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from dump" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from new" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from new" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from new" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from read" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from read" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from read" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from screenshot" -l output -d 'Output file path (default: /tmp/doubao-screenshot.png)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from screenshot" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from screenshot" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from screenshot" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from send" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from send" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from send" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from status" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from status" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from status" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from help" -f -a "ask" -d 'Send a message to Doubao desktop app and wait for the AI response'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from help" -f -a "dump" -d 'Dump Doubao desktop app DOM and snapshot to /tmp for debugging'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from help" -f -a "new" -d 'Start a new chat in Doubao desktop app'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from help" -f -a "read" -d 'Read chat history from Doubao desktop app'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from help" -f -a "screenshot" -d 'Capture a screenshot of the Doubao desktop app window'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from help" -f -a "send" -d 'Send a message to Doubao desktop app'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from help" -f -a "status" -d 'Check CDP connection to Doubao desktop app'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doubao-app; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and not __fish_seen_subcommand_from add-friend events feed friends groups join-group memories notifications profile search help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and not __fish_seen_subcommand_from add-friend events feed friends groups join-group memories notifications profile search help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and not __fish_seen_subcommand_from add-friend events feed friends groups join-group memories notifications profile search help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and not __fish_seen_subcommand_from add-friend events feed friends groups join-group memories notifications profile search help" -f -a "add-friend" -d 'Send a friend request on Facebook'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and not __fish_seen_subcommand_from add-friend events feed friends groups join-group memories notifications profile search help" -f -a "events" -d 'Browse Facebook event categories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and not __fish_seen_subcommand_from add-friend events feed friends groups join-group memories notifications profile search help" -f -a "feed" -d 'Get your Facebook news feed'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and not __fish_seen_subcommand_from add-friend events feed friends groups join-group memories notifications profile search help" -f -a "friends" -d 'Get Facebook friend suggestions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and not __fish_seen_subcommand_from add-friend events feed friends groups join-group memories notifications profile search help" -f -a "groups" -d 'List your Facebook groups'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and not __fish_seen_subcommand_from add-friend events feed friends groups join-group memories notifications profile search help" -f -a "join-group" -d 'Join a Facebook group'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and not __fish_seen_subcommand_from add-friend events feed friends groups join-group memories notifications profile search help" -f -a "memories" -d 'Get your Facebook memories (On This Day)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and not __fish_seen_subcommand_from add-friend events feed friends groups join-group memories notifications profile search help" -f -a "notifications" -d 'Get recent Facebook notifications'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and not __fish_seen_subcommand_from add-friend events feed friends groups join-group memories notifications profile search help" -f -a "profile" -d 'Get Facebook user/page profile info'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and not __fish_seen_subcommand_from add-friend events feed friends groups join-group memories notifications profile search help" -f -a "search" -d 'Search Facebook for people, pages, or posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and not __fish_seen_subcommand_from add-friend events feed friends groups join-group memories notifications profile search help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from add-friend" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from add-friend" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from add-friend" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from events" -l limit -d 'Number of categories' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from events" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from events" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from events" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from feed" -l limit -d 'Number of posts' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from feed" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from feed" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from feed" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from friends" -l limit -d 'Number of friend suggestions' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from friends" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from friends" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from friends" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from groups" -l limit -d 'Number of groups' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from groups" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from groups" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from groups" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from join-group" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from join-group" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from join-group" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from memories" -l limit -d 'Number of memories' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from memories" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from memories" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from memories" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from notifications" -l limit -d 'Number of notifications' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from notifications" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from notifications" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from notifications" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from profile" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from profile" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from profile" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from search" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from help" -f -a "add-friend" -d 'Send a friend request on Facebook'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from help" -f -a "events" -d 'Browse Facebook event categories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from help" -f -a "feed" -d 'Get your Facebook news feed'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from help" -f -a "friends" -d 'Get Facebook friend suggestions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from help" -f -a "groups" -d 'List your Facebook groups'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from help" -f -a "join-group" -d 'Join a Facebook group'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from help" -f -a "memories" -d 'Get your Facebook memories (On This Day)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from help" -f -a "notifications" -d 'Get recent Facebook notifications'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from help" -f -a "profile" -d 'Get Facebook user/page profile info'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search Facebook for people, pages, or posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand facebook; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and not __fish_seen_subcommand_from news search suggest trends help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and not __fish_seen_subcommand_from news search suggest trends help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and not __fish_seen_subcommand_from news search suggest trends help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and not __fish_seen_subcommand_from news search suggest trends help" -f -a "news" -d 'Get Google News headlines'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and not __fish_seen_subcommand_from news search suggest trends help" -f -a "search" -d 'Search Google'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and not __fish_seen_subcommand_from news search suggest trends help" -f -a "suggest" -d 'Get Google search suggestions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and not __fish_seen_subcommand_from news search suggest trends help" -f -a "trends" -d 'Get Google Trends daily trending searches'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and not __fish_seen_subcommand_from news search suggest trends help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from news" -l lang -d 'Language short code (e.g. en, zh)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from news" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from news" -l region -d 'Region code (e.g. US, CN)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from news" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from news" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from news" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from search" -l lang -d 'Language short code (e.g. en, zh)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from search" -l limit -d 'Number of results (1-100)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from suggest" -l lang -d 'Language code' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from suggest" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from suggest" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from suggest" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from trends" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from trends" -l region -d 'Region code (e.g. US, CN, JP)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from trends" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from trends" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from trends" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from help" -f -a "news" -d 'Get Google News headlines'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search Google'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from help" -f -a "suggest" -d 'Get Google search suggestions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from help" -f -a "trends" -d 'Get Google Trends daily trending searches'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand google; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand grok; and not __fish_seen_subcommand_from ask help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand grok; and not __fish_seen_subcommand_from ask help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand grok; and not __fish_seen_subcommand_from ask help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand grok; and not __fish_seen_subcommand_from ask help" -f -a "ask" -d 'Send a message to Grok and get response'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand grok; and not __fish_seen_subcommand_from ask help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand grok; and __fish_seen_subcommand_from ask" -l new -d 'Start a new chat before sending' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand grok; and __fish_seen_subcommand_from ask" -l timeout -d 'Max seconds to wait for response' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand grok; and __fish_seen_subcommand_from ask" -l web -d 'Use the explicit grok.com consumer web flow' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand grok; and __fish_seen_subcommand_from ask" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand grok; and __fish_seen_subcommand_from ask" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand grok; and __fish_seen_subcommand_from ask" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand grok; and __fish_seen_subcommand_from help" -f -a "ask" -d 'Send a message to Grok and get response'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand grok; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and not __fish_seen_subcommand_from ask best jobs new search show top user help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and not __fish_seen_subcommand_from ask best jobs new search show top user help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and not __fish_seen_subcommand_from ask best jobs new search show top user help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and not __fish_seen_subcommand_from ask best jobs new search show top user help" -f -a "ask" -d 'Hacker News Ask HN posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and not __fish_seen_subcommand_from ask best jobs new search show top user help" -f -a "best" -d 'Hacker News best stories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and not __fish_seen_subcommand_from ask best jobs new search show top user help" -f -a "jobs" -d 'Hacker News job postings'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and not __fish_seen_subcommand_from ask best jobs new search show top user help" -f -a "new" -d 'Hacker News newest stories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and not __fish_seen_subcommand_from ask best jobs new search show top user help" -f -a "search" -d 'Search Hacker News stories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and not __fish_seen_subcommand_from ask best jobs new search show top user help" -f -a "show" -d 'Hacker News Show HN posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and not __fish_seen_subcommand_from ask best jobs new search show top user help" -f -a "top" -d 'Hacker News top stories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and not __fish_seen_subcommand_from ask best jobs new search show top user help" -f -a "user" -d 'Hacker News user profile'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and not __fish_seen_subcommand_from ask best jobs new search show top user help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from ask" -l limit -d 'Number of stories' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from ask" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from ask" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from ask" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from best" -l limit -d 'Number of stories' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from best" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from best" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from best" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from jobs" -l limit -d 'Number of job postings' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from jobs" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from jobs" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from jobs" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from new" -l limit -d 'Number of stories' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from new" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from new" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from new" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from search" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from search" -l sort -d 'Sort by relevance or date' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from show" -l limit -d 'Number of stories' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from show" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from show" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from show" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from top" -l limit -d 'Number of stories' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from top" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from top" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from top" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from user" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from user" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from user" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from help" -f -a "ask" -d 'Hacker News Ask HN posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from help" -f -a "best" -d 'Hacker News best stories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from help" -f -a "jobs" -d 'Hacker News job postings'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from help" -f -a "new" -d 'Hacker News newest stories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search Hacker News stories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from help" -f -a "show" -d 'Hacker News Show HN posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from help" -f -a "top" -d 'Hacker News top stories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from help" -f -a "user" -d 'Hacker News user profile'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hackernews; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hf; and not __fish_seen_subcommand_from top help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hf; and not __fish_seen_subcommand_from top help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hf; and not __fish_seen_subcommand_from top help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hf; and not __fish_seen_subcommand_from top help" -f -a "top" -d 'Top upvoted Hugging Face papers'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hf; and not __fish_seen_subcommand_from top help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hf; and __fish_seen_subcommand_from top" -l all -d 'Return all papers (ignore limit)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hf; and __fish_seen_subcommand_from top" -l date -d 'Date (YYYY-MM-DD), defaults to most recent' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hf; and __fish_seen_subcommand_from top" -l limit -d 'Number of papers' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hf; and __fish_seen_subcommand_from top" -l period -d 'Time period: daily, weekly, or monthly' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hf; and __fish_seen_subcommand_from top" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hf; and __fish_seen_subcommand_from top" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hf; and __fish_seen_subcommand_from top" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hf; and __fish_seen_subcommand_from help" -f -a "top" -d 'Top upvoted Hugging Face papers'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand hf; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and not __fish_seen_subcommand_from comment explore follow followers following like profile save saved search unfollow unlike unsave user help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and not __fish_seen_subcommand_from comment explore follow followers following like profile save saved search unfollow unlike unsave user help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and not __fish_seen_subcommand_from comment explore follow followers following like profile save saved search unfollow unlike unsave user help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and not __fish_seen_subcommand_from comment explore follow followers following like profile save saved search unfollow unlike unsave user help" -f -a "comment" -d 'Comment on an Instagram post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and not __fish_seen_subcommand_from comment explore follow followers following like profile save saved search unfollow unlike unsave user help" -f -a "explore" -d 'Instagram explore/discover trending posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and not __fish_seen_subcommand_from comment explore follow followers following like profile save saved search unfollow unlike unsave user help" -f -a "follow" -d 'Follow an Instagram user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and not __fish_seen_subcommand_from comment explore follow followers following like profile save saved search unfollow unlike unsave user help" -f -a "followers" -d 'List followers of an Instagram user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and not __fish_seen_subcommand_from comment explore follow followers following like profile save saved search unfollow unlike unsave user help" -f -a "following" -d 'List accounts an Instagram user is following'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and not __fish_seen_subcommand_from comment explore follow followers following like profile save saved search unfollow unlike unsave user help" -f -a "like" -d 'Like an Instagram post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and not __fish_seen_subcommand_from comment explore follow followers following like profile save saved search unfollow unlike unsave user help" -f -a "profile" -d 'Get Instagram user profile info'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and not __fish_seen_subcommand_from comment explore follow followers following like profile save saved search unfollow unlike unsave user help" -f -a "save" -d 'Save (bookmark) an Instagram post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and not __fish_seen_subcommand_from comment explore follow followers following like profile save saved search unfollow unlike unsave user help" -f -a "saved" -d 'Get your saved Instagram posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and not __fish_seen_subcommand_from comment explore follow followers following like profile save saved search unfollow unlike unsave user help" -f -a "search" -d 'Search Instagram users'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and not __fish_seen_subcommand_from comment explore follow followers following like profile save saved search unfollow unlike unsave user help" -f -a "unfollow" -d 'Unfollow an Instagram user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and not __fish_seen_subcommand_from comment explore follow followers following like profile save saved search unfollow unlike unsave user help" -f -a "unlike" -d 'Unlike an Instagram post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and not __fish_seen_subcommand_from comment explore follow followers following like profile save saved search unfollow unlike unsave user help" -f -a "unsave" -d 'Unsave (remove bookmark) an Instagram post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and not __fish_seen_subcommand_from comment explore follow followers following like profile save saved search unfollow unlike unsave user help" -f -a "user" -d 'Get recent posts from an Instagram user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and not __fish_seen_subcommand_from comment explore follow followers following like profile save saved search unfollow unlike unsave user help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from comment" -l index -d 'Post index (1 = most recent)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from comment" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from comment" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from comment" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from explore" -l limit -d 'Number of posts' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from explore" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from explore" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from explore" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from follow" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from follow" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from follow" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from followers" -l limit -d 'Number of followers' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from followers" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from followers" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from followers" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from following" -l limit -d 'Number of accounts' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from following" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from following" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from following" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from like" -l index -d 'Post index (1 = most recent)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from like" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from like" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from like" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from profile" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from profile" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from profile" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from save" -l index -d 'Post index (1 = most recent)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from save" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from save" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from save" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from saved" -l limit -d 'Number of saved posts' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from saved" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from saved" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from saved" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from search" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from unfollow" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from unfollow" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from unfollow" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from unlike" -l index -d 'Post index (1 = most recent)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from unlike" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from unlike" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from unlike" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from unsave" -l index -d 'Post index (1 = most recent)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from unsave" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from unsave" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from unsave" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from user" -l limit -d 'Number of posts' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from user" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from user" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from user" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from help" -f -a "comment" -d 'Comment on an Instagram post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from help" -f -a "explore" -d 'Instagram explore/discover trending posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from help" -f -a "follow" -d 'Follow an Instagram user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from help" -f -a "followers" -d 'List followers of an Instagram user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from help" -f -a "following" -d 'List accounts an Instagram user is following'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from help" -f -a "like" -d 'Like an Instagram post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from help" -f -a "profile" -d 'Get Instagram user profile info'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from help" -f -a "save" -d 'Save (bookmark) an Instagram post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from help" -f -a "saved" -d 'Get your saved Instagram posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search Instagram users'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from help" -f -a "unfollow" -d 'Unfollow an Instagram user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from help" -f -a "unlike" -d 'Unlike an Instagram post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from help" -f -a "unsave" -d 'Unsave (remove bookmark) an Instagram post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from help" -f -a "user" -d 'Get recent posts from an Instagram user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand instagram; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and not __fish_seen_subcommand_from comment create feed like notifications post repost search topic user help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and not __fish_seen_subcommand_from comment create feed like notifications post repost search topic user help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and not __fish_seen_subcommand_from comment create feed like notifications post repost search topic user help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and not __fish_seen_subcommand_from comment create feed like notifications post repost search topic user help" -f -a "comment" -d '评论即刻帖子'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and not __fish_seen_subcommand_from comment create feed like notifications post repost search topic user help" -f -a "create" -d '发布即刻动态'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and not __fish_seen_subcommand_from comment create feed like notifications post repost search topic user help" -f -a "feed" -d '即刻首页动态流'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and not __fish_seen_subcommand_from comment create feed like notifications post repost search topic user help" -f -a "like" -d '点赞即刻帖子'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and not __fish_seen_subcommand_from comment create feed like notifications post repost search topic user help" -f -a "notifications" -d '即刻通知'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and not __fish_seen_subcommand_from comment create feed like notifications post repost search topic user help" -f -a "post" -d '即刻帖子详情及评论'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and not __fish_seen_subcommand_from comment create feed like notifications post repost search topic user help" -f -a "repost" -d '转发即刻帖子'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and not __fish_seen_subcommand_from comment create feed like notifications post repost search topic user help" -f -a "search" -d '搜索即刻帖子'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and not __fish_seen_subcommand_from comment create feed like notifications post repost search topic user help" -f -a "topic" -d '即刻话题/圈子帖子'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and not __fish_seen_subcommand_from comment create feed like notifications post repost search topic user help" -f -a "user" -d '即刻用户动态'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and not __fish_seen_subcommand_from comment create feed like notifications post repost search topic user help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from comment" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from comment" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from comment" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from create" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from create" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from feed" -l limit -d 'Number of posts' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from feed" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from feed" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from feed" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from like" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from like" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from like" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from notifications" -l limit -d 'Number of notifications' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from notifications" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from notifications" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from notifications" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from post" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from post" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from post" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from repost" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from repost" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from repost" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from search" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from topic" -l limit -d 'Number of posts' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from topic" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from topic" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from topic" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from user" -l limit -d 'Number of posts' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from user" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from user" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from user" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from help" -f -a "comment" -d '评论即刻帖子'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from help" -f -a "create" -d '发布即刻动态'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from help" -f -a "feed" -d '即刻首页动态流'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from help" -f -a "like" -d '点赞即刻帖子'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from help" -f -a "notifications" -d '即刻通知'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from help" -f -a "post" -d '即刻帖子详情及评论'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from help" -f -a "repost" -d '转发即刻帖子'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from help" -f -a "search" -d '搜索即刻帖子'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from help" -f -a "topic" -d '即刻话题/圈子帖子'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from help" -f -a "user" -d '即刻用户动态'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jike; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jimeng; and not __fish_seen_subcommand_from generate history help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jimeng; and not __fish_seen_subcommand_from generate history help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jimeng; and not __fish_seen_subcommand_from generate history help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jimeng; and not __fish_seen_subcommand_from generate history help" -f -a "generate" -d '即梦AI 文生图 — 输入 prompt 生成图片'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jimeng; and not __fish_seen_subcommand_from generate history help" -f -a "history" -d '即梦AI 查看最近生成的作品'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jimeng; and not __fish_seen_subcommand_from generate history help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jimeng; and __fish_seen_subcommand_from generate" -l model -d '模型: high_aes_general_v50 (5.0 Lite), high_aes_general_v42 (4.6), high_aes_general_v40 (4.0)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jimeng; and __fish_seen_subcommand_from generate" -l wait -d '等待生成完成的秒数' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jimeng; and __fish_seen_subcommand_from generate" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jimeng; and __fish_seen_subcommand_from generate" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jimeng; and __fish_seen_subcommand_from generate" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jimeng; and __fish_seen_subcommand_from history" -l limit -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jimeng; and __fish_seen_subcommand_from history" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jimeng; and __fish_seen_subcommand_from history" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jimeng; and __fish_seen_subcommand_from history" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jimeng; and __fish_seen_subcommand_from help" -f -a "generate" -d '即梦AI 文生图 — 输入 prompt 生成图片'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jimeng; and __fish_seen_subcommand_from help" -f -a "history" -d '即梦AI 查看最近生成的作品'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand jimeng; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linkedin; and not __fish_seen_subcommand_from search help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linkedin; and not __fish_seen_subcommand_from search help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linkedin; and not __fish_seen_subcommand_from search help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linkedin; and not __fish_seen_subcommand_from search help" -f -a "search" -d 'Search LinkedIn jobs'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linkedin; and not __fish_seen_subcommand_from search help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linkedin; and __fish_seen_subcommand_from search" -l limit -d 'Number of jobs to return (max 100)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linkedin; and __fish_seen_subcommand_from search" -l location -d 'Location text such as San Francisco Bay Area' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linkedin; and __fish_seen_subcommand_from search" -l start -d 'Result offset for pagination' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linkedin; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linkedin; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linkedin; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linkedin; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search LinkedIn jobs'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linkedin; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and not __fish_seen_subcommand_from categories category hot latest search topic help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and not __fish_seen_subcommand_from categories category hot latest search topic help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and not __fish_seen_subcommand_from categories category hot latest search topic help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and not __fish_seen_subcommand_from categories category hot latest search topic help" -f -a "categories" -d 'linux.do 分类列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and not __fish_seen_subcommand_from categories category hot latest search topic help" -f -a "category" -d 'linux.do 分类内话题'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and not __fish_seen_subcommand_from categories category hot latest search topic help" -f -a "hot" -d 'linux.do 热门话题'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and not __fish_seen_subcommand_from categories category hot latest search topic help" -f -a "latest" -d 'linux.do 最新话题'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and not __fish_seen_subcommand_from categories category hot latest search topic help" -f -a "search" -d '搜索 linux.do'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and not __fish_seen_subcommand_from categories category hot latest search topic help" -f -a "topic" -d 'linux.do 帖子详情和回复（首页）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and not __fish_seen_subcommand_from categories category hot latest search topic help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from categories" -l limit -d 'Number of categories' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from categories" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from categories" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from categories" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from category" -l limit -d 'Number of topics' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from category" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from category" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from category" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from hot" -l limit -d 'Number of topics' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from hot" -l period -d 'Time period' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from hot" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from hot" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from hot" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from latest" -l limit -d 'Number of topics' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from latest" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from latest" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from latest" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from search" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from topic" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from topic" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from topic" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from help" -f -a "categories" -d 'linux.do 分类列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from help" -f -a "category" -d 'linux.do 分类内话题'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from help" -f -a "hot" -d 'linux.do 热门话题'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from help" -f -a "latest" -d 'linux.do 最新话题'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from help" -f -a "search" -d '搜索 linux.do'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from help" -f -a "topic" -d 'linux.do 帖子详情和回复（首页）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand linux-do; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and not __fish_seen_subcommand_from active hot newest tag help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and not __fish_seen_subcommand_from active hot newest tag help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and not __fish_seen_subcommand_from active hot newest tag help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and not __fish_seen_subcommand_from active hot newest tag help" -f -a "active" -d 'Lobste.rs most active discussions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and not __fish_seen_subcommand_from active hot newest tag help" -f -a "hot" -d 'Lobste.rs hottest stories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and not __fish_seen_subcommand_from active hot newest tag help" -f -a "newest" -d 'Lobste.rs newest stories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and not __fish_seen_subcommand_from active hot newest tag help" -f -a "tag" -d 'Lobste.rs stories by tag'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and not __fish_seen_subcommand_from active hot newest tag help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from active" -l limit -d 'Number of stories' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from active" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from active" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from active" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from hot" -l limit -d 'Number of stories' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from hot" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from hot" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from hot" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from newest" -l limit -d 'Number of stories' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from newest" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from newest" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from newest" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from tag" -l limit -d 'Number of stories' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from tag" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from tag" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from tag" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from help" -f -a "active" -d 'Lobste.rs most active discussions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from help" -f -a "hot" -d 'Lobste.rs hottest stories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from help" -f -a "newest" -d 'Lobste.rs newest stories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from help" -f -a "tag" -d 'Lobste.rs stories by tag'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand lobsters; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and not __fish_seen_subcommand_from feed search user help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and not __fish_seen_subcommand_from feed search user help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and not __fish_seen_subcommand_from feed search user help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and not __fish_seen_subcommand_from feed search user help" -f -a "feed" -d 'Medium 热门文章 Feed'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and not __fish_seen_subcommand_from feed search user help" -f -a "search" -d '搜索 Medium 文章'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and not __fish_seen_subcommand_from feed search user help" -f -a "user" -d '获取 Medium 用户的文章列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and not __fish_seen_subcommand_from feed search user help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and __fish_seen_subcommand_from feed" -l limit -d '返回的文章数量' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and __fish_seen_subcommand_from feed" -l topic -d '话题标签（如 technology, programming, ai）' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and __fish_seen_subcommand_from feed" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and __fish_seen_subcommand_from feed" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and __fish_seen_subcommand_from feed" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and __fish_seen_subcommand_from search" -l limit -d '返回的文章数量' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and __fish_seen_subcommand_from user" -l limit -d '返回的文章数量' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and __fish_seen_subcommand_from user" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and __fish_seen_subcommand_from user" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and __fish_seen_subcommand_from user" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and __fish_seen_subcommand_from help" -f -a "feed" -d 'Medium 热门文章 Feed'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and __fish_seen_subcommand_from help" -f -a "search" -d '搜索 Medium 文章'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and __fish_seen_subcommand_from help" -f -a "user" -d '获取 Medium 用户的文章列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand medium; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and not __fish_seen_subcommand_from export favorites new read search sidebar status write help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and not __fish_seen_subcommand_from export favorites new read search sidebar status write help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and not __fish_seen_subcommand_from export favorites new read search sidebar status write help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and not __fish_seen_subcommand_from export favorites new read search sidebar status write help" -f -a "export" -d 'Export the current Notion page as Markdown'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and not __fish_seen_subcommand_from export favorites new read search sidebar status write help" -f -a "favorites" -d 'List pages from the Notion Favorites section in the sidebar'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and not __fish_seen_subcommand_from export favorites new read search sidebar status write help" -f -a "new" -d 'Create a new page in Notion'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and not __fish_seen_subcommand_from export favorites new read search sidebar status write help" -f -a "read" -d 'Read the content of the currently open Notion page'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and not __fish_seen_subcommand_from export favorites new read search sidebar status write help" -f -a "search" -d 'Search pages and databases in Notion via Quick Find (Cmd+P)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and not __fish_seen_subcommand_from export favorites new read search sidebar status write help" -f -a "sidebar" -d 'List pages and databases from the Notion sidebar'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and not __fish_seen_subcommand_from export favorites new read search sidebar status write help" -f -a "status" -d 'Check active CDP connection to Notion Desktop'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and not __fish_seen_subcommand_from export favorites new read search sidebar status write help" -f -a "write" -d 'Append text content to the currently open Notion page'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and not __fish_seen_subcommand_from export favorites new read search sidebar status write help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from export" -l output -d 'Output file (default: /tmp/notion-export.md)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from export" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from export" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from export" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from favorites" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from favorites" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from favorites" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from new" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from new" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from new" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from read" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from read" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from read" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from sidebar" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from sidebar" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from sidebar" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from status" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from status" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from status" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from write" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from write" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from write" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from help" -f -a "export" -d 'Export the current Notion page as Markdown'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from help" -f -a "favorites" -d 'List pages from the Notion Favorites section in the sidebar'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from help" -f -a "new" -d 'Create a new page in Notion'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from help" -f -a "read" -d 'Read the content of the currently open Notion page'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search pages and databases in Notion via Quick Find (Cmd+P)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from help" -f -a "sidebar" -d 'List pages and databases from the Notion sidebar'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from help" -f -a "status" -d 'Check active CDP connection to Notion Desktop'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from help" -f -a "write" -d 'Append text content to the currently open Notion page'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand notion; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -f -a "comment" -d 'Post a comment on a Reddit post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -f -a "frontpage" -d 'Reddit Frontpage / r/all'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -f -a "hot" -d 'Reddit 热门帖子'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -f -a "popular" -d 'Reddit Popular posts (/r/popular)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -f -a "read" -d 'Read a Reddit post and its comments'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -f -a "save" -d 'Save or unsave a Reddit post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -f -a "saved" -d 'Browse your saved Reddit posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -f -a "search" -d 'Search Reddit Posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -f -a "subreddit" -d 'Get posts from a specific Subreddit'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -f -a "subscribe" -d 'Subscribe or unsubscribe to a subreddit'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -f -a "upvote" -d 'Upvote or downvote a Reddit post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -f -a "upvoted" -d 'Browse your upvoted Reddit posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -f -a "user" -d 'View a Reddit user profile'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -f -a "user-comments" -d 'View a Reddit user\'s comment history'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -f -a "user-posts" -d 'View a Reddit user\'s submitted posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and not __fish_seen_subcommand_from comment frontpage hot popular read save saved search subreddit subscribe upvote upvoted user user-comments user-posts help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from comment" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from comment" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from comment" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from frontpage" -l limit -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from frontpage" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from frontpage" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from frontpage" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from hot" -l limit -d 'Number of posts' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from hot" -l subreddit -d 'Subreddit name (e.g. programming). Empty for frontpage' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from hot" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from hot" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from hot" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from popular" -l limit -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from popular" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from popular" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from popular" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from read" -l depth -d 'Max reply depth (1=no replies, 2=one level, etc.)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from read" -l limit -d 'Number of top-level comments' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from read" -l max-length -d 'Max characters per comment body (min 100)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from read" -l replies -d 'Max replies shown per comment at each level' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from read" -l sort -d 'Comment sort: best, top, new, controversial, old, qa' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from read" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from read" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from read" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from save" -l undo -d 'Unsave instead of save' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from save" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from save" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from save" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from saved" -l limit -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from saved" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from saved" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from saved" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from search" -l limit -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from search" -l sort -d 'Sort order: relevance, hot, top, new, comments' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from search" -l subreddit -d 'Search within a specific subreddit' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from search" -l time -d 'Time filter: hour, day, week, month, year, all' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from subreddit" -l limit -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from subreddit" -l sort -d 'Sorting method: hot, new, top, rising, controversial' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from subreddit" -l time -d 'Time filter for top/controversial: hour, day, week, month, year, all' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from subreddit" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from subreddit" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from subreddit" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from subscribe" -l undo -d 'Unsubscribe instead of subscribe' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from subscribe" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from subscribe" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from subscribe" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from upvote" -l direction -d 'Vote direction: up, down, none' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from upvote" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from upvote" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from upvote" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from upvoted" -l limit -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from upvoted" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from upvoted" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from upvoted" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from user" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from user" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from user" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from user-comments" -l limit -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from user-comments" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from user-comments" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from user-comments" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from user-posts" -l limit -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from user-posts" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from user-posts" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from user-posts" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from help" -f -a "comment" -d 'Post a comment on a Reddit post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from help" -f -a "frontpage" -d 'Reddit Frontpage / r/all'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from help" -f -a "hot" -d 'Reddit 热门帖子'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from help" -f -a "popular" -d 'Reddit Popular posts (/r/popular)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from help" -f -a "read" -d 'Read a Reddit post and its comments'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from help" -f -a "save" -d 'Save or unsave a Reddit post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from help" -f -a "saved" -d 'Browse your saved Reddit posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search Reddit Posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from help" -f -a "subreddit" -d 'Get posts from a specific Subreddit'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from help" -f -a "subscribe" -d 'Subscribe or unsubscribe to a subreddit'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from help" -f -a "upvote" -d 'Upvote or downvote a Reddit post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from help" -f -a "upvoted" -d 'Browse your upvoted Reddit posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from help" -f -a "user" -d 'View a Reddit user profile'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from help" -f -a "user-comments" -d 'View a Reddit user\'s comment history'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from help" -f -a "user-posts" -d 'View a Reddit user\'s submitted posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reddit; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reuters; and not __fish_seen_subcommand_from search help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reuters; and not __fish_seen_subcommand_from search help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reuters; and not __fish_seen_subcommand_from search help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reuters; and not __fish_seen_subcommand_from search help" -f -a "search" -d 'Reuters 路透社新闻搜索'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reuters; and not __fish_seen_subcommand_from search help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reuters; and __fish_seen_subcommand_from search" -l limit -d 'Number of results (max 40)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reuters; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reuters; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reuters; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reuters; and __fish_seen_subcommand_from help" -f -a "search" -d 'Reuters 路透社新闻搜索'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand reuters; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and not __fish_seen_subcommand_from article hot search user help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and not __fish_seen_subcommand_from article hot search user help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and not __fish_seen_subcommand_from article hot search user help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and not __fish_seen_subcommand_from article hot search user help" -f -a "article" -d '获取新浪博客单篇文章详情'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and not __fish_seen_subcommand_from article hot search user help" -f -a "hot" -d '获取新浪博客热门文章/推荐'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and not __fish_seen_subcommand_from article hot search user help" -f -a "search" -d '搜索新浪博客文章（通过新浪搜索）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and not __fish_seen_subcommand_from article hot search user help" -f -a "user" -d '获取新浪博客用户的文章列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and not __fish_seen_subcommand_from article hot search user help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from article" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from article" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from article" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from hot" -l limit -d '返回的文章数量' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from hot" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from hot" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from hot" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from search" -l limit -d '返回的文章数量' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from user" -l limit -d '返回的文章数量' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from user" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from user" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from user" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from help" -f -a "article" -d '获取新浪博客单篇文章详情'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from help" -f -a "hot" -d '获取新浪博客热门文章/推荐'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from help" -f -a "search" -d '搜索新浪博客文章（通过新浪搜索）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from help" -f -a "user" -d '获取新浪博客用户的文章列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinablog; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinafinance; and not __fish_seen_subcommand_from news help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinafinance; and not __fish_seen_subcommand_from news help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinafinance; and not __fish_seen_subcommand_from news help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinafinance; and not __fish_seen_subcommand_from news help" -f -a "news" -d '新浪财经 7x24 小时实时快讯'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinafinance; and not __fish_seen_subcommand_from news help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinafinance; and __fish_seen_subcommand_from news" -l limit -d 'Max results (max 50)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinafinance; and __fish_seen_subcommand_from news" -l type -d 'News type: 0=全部 1=A股 2=宏观 3=公司 4=数据 5=市场 6=国际 7=观点 8=央行 9=其它' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinafinance; and __fish_seen_subcommand_from news" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinafinance; and __fish_seen_subcommand_from news" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinafinance; and __fish_seen_subcommand_from news" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinafinance; and __fish_seen_subcommand_from help" -f -a "news" -d '新浪财经 7x24 小时实时快讯'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand sinafinance; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand smzdm; and not __fish_seen_subcommand_from search help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand smzdm; and not __fish_seen_subcommand_from search help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand smzdm; and not __fish_seen_subcommand_from search help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand smzdm; and not __fish_seen_subcommand_from search help" -f -a "search" -d '什么值得买搜索好价'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand smzdm; and not __fish_seen_subcommand_from search help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand smzdm; and __fish_seen_subcommand_from search" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand smzdm; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand smzdm; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand smzdm; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand smzdm; and __fish_seen_subcommand_from help" -f -a "search" -d '什么值得买搜索好价'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand smzdm; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and not __fish_seen_subcommand_from bounties hot search unanswered help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and not __fish_seen_subcommand_from bounties hot search unanswered help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and not __fish_seen_subcommand_from bounties hot search unanswered help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and not __fish_seen_subcommand_from bounties hot search unanswered help" -f -a "bounties" -d 'Active bounties on Stack Overflow'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and not __fish_seen_subcommand_from bounties hot search unanswered help" -f -a "hot" -d 'Hot Stack Overflow questions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and not __fish_seen_subcommand_from bounties hot search unanswered help" -f -a "search" -d 'Search Stack Overflow questions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and not __fish_seen_subcommand_from bounties hot search unanswered help" -f -a "unanswered" -d 'Top voted unanswered questions on Stack Overflow'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and not __fish_seen_subcommand_from bounties hot search unanswered help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from bounties" -l limit -d 'Max number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from bounties" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from bounties" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from bounties" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from hot" -l limit -d 'Max number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from hot" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from hot" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from hot" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from search" -l limit -d 'Max number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from unanswered" -l limit -d 'Max number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from unanswered" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from unanswered" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from unanswered" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from help" -f -a "bounties" -d 'Active bounties on Stack Overflow'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from help" -f -a "hot" -d 'Hot Stack Overflow questions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search Stack Overflow questions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from help" -f -a "unanswered" -d 'Top voted unanswered questions on Stack Overflow'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand stackoverflow; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand steam; and not __fish_seen_subcommand_from top-sellers help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand steam; and not __fish_seen_subcommand_from top-sellers help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand steam; and not __fish_seen_subcommand_from top-sellers help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand steam; and not __fish_seen_subcommand_from top-sellers help" -f -a "top-sellers" -d 'Steam top selling games'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand steam; and not __fish_seen_subcommand_from top-sellers help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand steam; and __fish_seen_subcommand_from top-sellers" -l limit -d 'Number of games' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand steam; and __fish_seen_subcommand_from top-sellers" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand steam; and __fish_seen_subcommand_from top-sellers" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand steam; and __fish_seen_subcommand_from top-sellers" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand steam; and __fish_seen_subcommand_from help" -f -a "top-sellers" -d 'Steam top selling games'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand steam; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and not __fish_seen_subcommand_from feed publication search help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and not __fish_seen_subcommand_from feed publication search help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and not __fish_seen_subcommand_from feed publication search help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and not __fish_seen_subcommand_from feed publication search help" -f -a "feed" -d 'Substack 热门文章 Feed'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and not __fish_seen_subcommand_from feed publication search help" -f -a "publication" -d '获取特定 Substack Newsletter 的最新文章'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and not __fish_seen_subcommand_from feed publication search help" -f -a "search" -d '搜索 Substack 文章和 Newsletter'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and not __fish_seen_subcommand_from feed publication search help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and __fish_seen_subcommand_from feed" -l category -d '文章分类: all, tech, business, culture, politics, science, health' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and __fish_seen_subcommand_from feed" -l limit -d '返回的文章数量' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and __fish_seen_subcommand_from feed" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and __fish_seen_subcommand_from feed" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and __fish_seen_subcommand_from feed" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and __fish_seen_subcommand_from publication" -l limit -d '返回的文章数量' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and __fish_seen_subcommand_from publication" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and __fish_seen_subcommand_from publication" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and __fish_seen_subcommand_from publication" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and __fish_seen_subcommand_from search" -l limit -d '返回结果数量' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and __fish_seen_subcommand_from search" -l type -d '搜索类型（posts=文章, publications=Newsletter）' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and __fish_seen_subcommand_from help" -f -a "feed" -d 'Substack 热门文章 Feed'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and __fish_seen_subcommand_from help" -f -a "publication" -d '获取特定 Substack Newsletter 的最新文章'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and __fish_seen_subcommand_from help" -f -a "search" -d '搜索 Substack 文章和 Newsletter'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand substack; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -f -a "comment" -d 'Comment on a TikTok video'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -f -a "explore" -d 'Get trending TikTok videos from explore page'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -f -a "follow" -d 'Follow a TikTok user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -f -a "following" -d 'List accounts you follow on TikTok'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -f -a "friends" -d 'Get TikTok friend suggestions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -f -a "like" -d 'Like a TikTok video'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -f -a "live" -d 'Browse live streams on TikTok'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -f -a "notifications" -d 'Get TikTok notifications (likes, comments, mentions, followers)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -f -a "profile" -d 'Get TikTok user profile info'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -f -a "save" -d 'Add a TikTok video to Favorites'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -f -a "search" -d 'Search TikTok videos'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -f -a "unfollow" -d 'Unfollow a TikTok user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -f -a "unlike" -d 'Unlike a TikTok video'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -f -a "unsave" -d 'Remove a TikTok video from Favorites'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -f -a "user" -d 'Get recent videos from a TikTok user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and not __fish_seen_subcommand_from comment explore follow following friends like live notifications profile save search unfollow unlike unsave user help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from comment" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from comment" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from comment" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from explore" -l limit -d 'Number of videos' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from explore" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from explore" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from explore" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from follow" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from follow" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from follow" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from following" -l limit -d 'Number of accounts' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from following" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from following" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from following" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from friends" -l limit -d 'Number of suggestions' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from friends" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from friends" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from friends" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from like" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from like" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from like" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from live" -l limit -d 'Number of streams' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from live" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from live" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from live" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from notifications" -l limit -d 'Number of notifications' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from notifications" -l type -d 'Notification type' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from notifications" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from notifications" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from notifications" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from profile" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from profile" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from profile" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from save" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from save" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from save" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from search" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from unfollow" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from unfollow" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from unfollow" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from unlike" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from unlike" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from unlike" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from unsave" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from unsave" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from unsave" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from user" -l limit -d 'Number of videos' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from user" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from user" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from user" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from help" -f -a "comment" -d 'Comment on a TikTok video'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from help" -f -a "explore" -d 'Get trending TikTok videos from explore page'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from help" -f -a "follow" -d 'Follow a TikTok user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from help" -f -a "following" -d 'List accounts you follow on TikTok'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from help" -f -a "friends" -d 'Get TikTok friend suggestions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from help" -f -a "like" -d 'Like a TikTok video'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from help" -f -a "live" -d 'Browse live streams on TikTok'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from help" -f -a "notifications" -d 'Get TikTok notifications (likes, comments, mentions, followers)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from help" -f -a "profile" -d 'Get TikTok user profile info'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from help" -f -a "save" -d 'Add a TikTok video to Favorites'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search TikTok videos'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from help" -f -a "unfollow" -d 'Unfollow a TikTok user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from help" -f -a "unlike" -d 'Unlike a TikTok video'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from help" -f -a "unsave" -d 'Remove a TikTok video from Favorites'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from help" -f -a "user" -d 'Get recent videos from a TikTok user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand tiktok; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "accept" -d 'Auto-accept DM requests containing specific keywords'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "article" -d 'Fetch a Twitter Article (long-form content) and export as Markdown'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "block" -d 'Block a Twitter user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "bookmark" -d 'Bookmark a tweet'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "bookmarks" -d 'Fetch Twitter/X bookmarks'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "delete" -d 'Delete a specific tweet by URL'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "download" -d '下载 Twitter/X 媒体（图片和视频）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "follow" -d 'Follow a Twitter user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "followers" -d 'Get accounts following a Twitter/X user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "following" -d 'Get accounts a Twitter/X user is following'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "hide-reply" -d 'Hide a reply on your tweet (useful for hiding bot/spam replies)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "like" -d 'Like a specific tweet'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "notifications" -d 'Get Twitter/X notifications'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "post" -d 'Post a new tweet/thread'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "profile" -d 'Fetch a Twitter user profile (bio, stats, etc.)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "reply" -d 'Reply to a specific tweet'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "reply-dm" -d 'Send a message to recent DM conversations'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "search" -d 'Search Twitter/X for tweets'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "thread" -d 'Get a tweet thread (original + all replies)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "timeline" -d 'Fetch Twitter timeline (for-you or following)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "trending" -d 'Twitter/X trending topics'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "unblock" -d 'Unblock a Twitter user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "unbookmark" -d 'Remove a tweet from bookmarks'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "unfollow" -d 'Unfollow a Twitter user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and not __fish_seen_subcommand_from accept article block bookmark bookmarks delete download follow followers following hide-reply like notifications post profile reply reply-dm search thread timeline trending unblock unbookmark unfollow help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from accept" -l max -d 'Maximum number of requests to accept' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from accept" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from accept" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from accept" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from article" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from article" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from article" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from block" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from block" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from block" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from bookmark" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from bookmark" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from bookmark" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from bookmarks" -l limit -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from bookmarks" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from bookmarks" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from bookmarks" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from delete" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from delete" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from download" -l limit -d 'Number of tweets to scan' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from download" -l output -d 'Output directory' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from download" -l tweet-url -d 'Single tweet URL to download' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from download" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from download" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from download" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from follow" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from follow" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from follow" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from followers" -l limit -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from followers" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from followers" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from followers" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from following" -l limit -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from following" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from following" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from following" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from hide-reply" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from hide-reply" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from hide-reply" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from like" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from like" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from like" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from notifications" -l limit -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from notifications" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from notifications" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from notifications" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from post" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from post" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from post" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from profile" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from profile" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from profile" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from reply" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from reply" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from reply" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from reply-dm" -l max -d 'Maximum number of conversations to reply to' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from reply-dm" -l skip-replied -d 'Skip conversations where you already sent the same text' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from reply-dm" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from reply-dm" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from reply-dm" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from search" -l limit -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from thread" -l limit -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from thread" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from thread" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from thread" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from timeline" -l limit -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from timeline" -l type -d 'Timeline type: for-you (algorithmic) or following (chronological)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from timeline" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from timeline" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from timeline" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from trending" -l limit -d 'Number of trends to show' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from trending" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from trending" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from trending" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from unblock" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from unblock" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from unblock" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from unbookmark" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from unbookmark" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from unbookmark" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from unfollow" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from unfollow" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from unfollow" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "accept" -d 'Auto-accept DM requests containing specific keywords'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "article" -d 'Fetch a Twitter Article (long-form content) and export as Markdown'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "block" -d 'Block a Twitter user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "bookmark" -d 'Bookmark a tweet'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "bookmarks" -d 'Fetch Twitter/X bookmarks'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a specific tweet by URL'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "download" -d '下载 Twitter/X 媒体（图片和视频）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "follow" -d 'Follow a Twitter user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "followers" -d 'Get accounts following a Twitter/X user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "following" -d 'Get accounts a Twitter/X user is following'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "hide-reply" -d 'Hide a reply on your tweet (useful for hiding bot/spam replies)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "like" -d 'Like a specific tweet'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "notifications" -d 'Get Twitter/X notifications'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "post" -d 'Post a new tweet/thread'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "profile" -d 'Fetch a Twitter user profile (bio, stats, etc.)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "reply" -d 'Reply to a specific tweet'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "reply-dm" -d 'Send a message to recent DM conversations'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search Twitter/X for tweets'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "thread" -d 'Get a tweet thread (original + all replies)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "timeline" -d 'Fetch Twitter timeline (for-you or following)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "trending" -d 'Twitter/X trending topics'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "unblock" -d 'Unblock a Twitter user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "unbookmark" -d 'Remove a tweet from bookmarks'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "unfollow" -d 'Unfollow a Twitter user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand twitter; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and not __fish_seen_subcommand_from daily hot latest me member node nodes notifications replies topic user help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and not __fish_seen_subcommand_from daily hot latest me member node nodes notifications replies topic user help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and not __fish_seen_subcommand_from daily hot latest me member node nodes notifications replies topic user help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and not __fish_seen_subcommand_from daily hot latest me member node nodes notifications replies topic user help" -f -a "daily" -d 'V2EX 每日签到并领取铜币'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and not __fish_seen_subcommand_from daily hot latest me member node nodes notifications replies topic user help" -f -a "hot" -d 'V2EX 热门话题'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and not __fish_seen_subcommand_from daily hot latest me member node nodes notifications replies topic user help" -f -a "latest" -d 'V2EX 最新话题'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and not __fish_seen_subcommand_from daily hot latest me member node nodes notifications replies topic user help" -f -a "me" -d 'V2EX 获取个人资料 (余额/未读提醒)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and not __fish_seen_subcommand_from daily hot latest me member node nodes notifications replies topic user help" -f -a "member" -d 'V2EX 用户资料'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and not __fish_seen_subcommand_from daily hot latest me member node nodes notifications replies topic user help" -f -a "node" -d 'V2EX 节点话题列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and not __fish_seen_subcommand_from daily hot latest me member node nodes notifications replies topic user help" -f -a "nodes" -d 'V2EX 所有节点列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and not __fish_seen_subcommand_from daily hot latest me member node nodes notifications replies topic user help" -f -a "notifications" -d 'V2EX 获取提醒 (回复/感谢)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and not __fish_seen_subcommand_from daily hot latest me member node nodes notifications replies topic user help" -f -a "replies" -d 'V2EX 主题回复列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and not __fish_seen_subcommand_from daily hot latest me member node nodes notifications replies topic user help" -f -a "topic" -d 'V2EX 主题详情和回复'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and not __fish_seen_subcommand_from daily hot latest me member node nodes notifications replies topic user help" -f -a "user" -d 'V2EX 用户发帖列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and not __fish_seen_subcommand_from daily hot latest me member node nodes notifications replies topic user help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from daily" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from daily" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from daily" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from hot" -l limit -d 'Number of topics' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from hot" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from hot" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from hot" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from latest" -l limit -d 'Number of topics' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from latest" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from latest" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from latest" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from me" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from me" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from me" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from member" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from member" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from member" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from node" -l limit -d 'Number of topics (API returns max 20)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from node" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from node" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from node" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from nodes" -l limit -d 'Number of nodes' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from nodes" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from nodes" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from nodes" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from notifications" -l limit -d 'Number of notifications' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from notifications" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from notifications" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from notifications" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from replies" -l limit -d 'Number of replies' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from replies" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from replies" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from replies" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from topic" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from topic" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from topic" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from user" -l limit -d 'Number of topics (API returns max 20)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from user" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from user" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from user" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from help" -f -a "daily" -d 'V2EX 每日签到并领取铜币'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from help" -f -a "hot" -d 'V2EX 热门话题'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from help" -f -a "latest" -d 'V2EX 最新话题'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from help" -f -a "me" -d 'V2EX 获取个人资料 (余额/未读提醒)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from help" -f -a "member" -d 'V2EX 用户资料'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from help" -f -a "node" -d 'V2EX 节点话题列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from help" -f -a "nodes" -d 'V2EX 所有节点列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from help" -f -a "notifications" -d 'V2EX 获取提醒 (回复/感谢)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from help" -f -a "replies" -d 'V2EX 主题回复列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from help" -f -a "topic" -d 'V2EX 主题详情和回复'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from help" -f -a "user" -d 'V2EX 用户发帖列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand v2ex; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weibo; and not __fish_seen_subcommand_from hot search help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weibo; and not __fish_seen_subcommand_from hot search help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weibo; and not __fish_seen_subcommand_from hot search help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weibo; and not __fish_seen_subcommand_from hot search help" -f -a "hot" -d '微博热搜'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weibo; and not __fish_seen_subcommand_from hot search help" -f -a "search" -d '搜索微博'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weibo; and not __fish_seen_subcommand_from hot search help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weibo; and __fish_seen_subcommand_from hot" -l limit -d 'Number of items (max 50)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weibo; and __fish_seen_subcommand_from hot" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weibo; and __fish_seen_subcommand_from hot" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weibo; and __fish_seen_subcommand_from hot" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weibo; and __fish_seen_subcommand_from search" -l limit -d 'Number of results (max 50)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weibo; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weibo; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weibo; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weibo; and __fish_seen_subcommand_from help" -f -a "hot" -d '微博热搜'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weibo; and __fish_seen_subcommand_from help" -f -a "search" -d '搜索微博'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weibo; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weixin; and not __fish_seen_subcommand_from download help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weixin; and not __fish_seen_subcommand_from download help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weixin; and not __fish_seen_subcommand_from download help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weixin; and not __fish_seen_subcommand_from download help" -f -a "download" -d '下载微信公众号文章为 Markdown 格式'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weixin; and not __fish_seen_subcommand_from download help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weixin; and __fish_seen_subcommand_from download" -l output -d 'Output directory' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weixin; and __fish_seen_subcommand_from download" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weixin; and __fish_seen_subcommand_from download" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weixin; and __fish_seen_subcommand_from download" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weixin; and __fish_seen_subcommand_from help" -f -a "download" -d '下载微信公众号文章为 Markdown 格式'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weixin; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and not __fish_seen_subcommand_from book highlights notebooks notes ranking search shelf help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and not __fish_seen_subcommand_from book highlights notebooks notes ranking search shelf help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and not __fish_seen_subcommand_from book highlights notebooks notes ranking search shelf help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and not __fish_seen_subcommand_from book highlights notebooks notes ranking search shelf help" -f -a "book" -d 'View book details on WeRead'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and not __fish_seen_subcommand_from book highlights notebooks notes ranking search shelf help" -f -a "highlights" -d 'List your highlights (underlines) in a book'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and not __fish_seen_subcommand_from book highlights notebooks notes ranking search shelf help" -f -a "notebooks" -d 'List books that have highlights or notes'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and not __fish_seen_subcommand_from book highlights notebooks notes ranking search shelf help" -f -a "notes" -d 'List your notes (thoughts) on a book'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and not __fish_seen_subcommand_from book highlights notebooks notes ranking search shelf help" -f -a "ranking" -d 'WeRead book rankings by category'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and not __fish_seen_subcommand_from book highlights notebooks notes ranking search shelf help" -f -a "search" -d 'Search books on WeRead'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and not __fish_seen_subcommand_from book highlights notebooks notes ranking search shelf help" -f -a "shelf" -d 'List books on your WeRead bookshelf'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and not __fish_seen_subcommand_from book highlights notebooks notes ranking search shelf help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from book" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from book" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from book" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from highlights" -l limit -d 'Max results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from highlights" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from highlights" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from highlights" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from notebooks" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from notebooks" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from notebooks" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from notes" -l limit -d 'Max results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from notes" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from notes" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from notes" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from ranking" -l limit -d 'Max results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from ranking" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from ranking" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from ranking" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from search" -l limit -d 'Max results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from shelf" -l limit -d 'Max results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from shelf" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from shelf" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from shelf" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from help" -f -a "book" -d 'View book details on WeRead'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from help" -f -a "highlights" -d 'List your highlights (underlines) in a book'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from help" -f -a "notebooks" -d 'List books that have highlights or notes'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from help" -f -a "notes" -d 'List your notes (thoughts) on a book'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from help" -f -a "ranking" -d 'WeRead book rankings by category'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search books on WeRead'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from help" -f -a "shelf" -d 'List books on your WeRead bookshelf'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand weread; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and not __fish_seen_subcommand_from random search summary trending help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and not __fish_seen_subcommand_from random search summary trending help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and not __fish_seen_subcommand_from random search summary trending help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and not __fish_seen_subcommand_from random search summary trending help" -f -a "random" -d 'Get a random Wikipedia article'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and not __fish_seen_subcommand_from random search summary trending help" -f -a "search" -d 'Search Wikipedia articles'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and not __fish_seen_subcommand_from random search summary trending help" -f -a "summary" -d 'Get Wikipedia article summary'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and not __fish_seen_subcommand_from random search summary trending help" -f -a "trending" -d 'Most-read Wikipedia articles (yesterday)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and not __fish_seen_subcommand_from random search summary trending help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from random" -l lang -d 'Language code (e.g. en, zh, ja)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from random" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from random" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from random" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from search" -l lang -d 'Language code (e.g. en, zh, ja)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from search" -l limit -d 'Max results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from summary" -l lang -d 'Language code (e.g. en, zh, ja)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from summary" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from summary" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from summary" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from trending" -l lang -d 'Language code (e.g. en, zh, ja)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from trending" -l limit -d 'Max results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from trending" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from trending" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from trending" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from help" -f -a "random" -d 'Get a random Wikipedia article'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search Wikipedia articles'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from help" -f -a "summary" -d 'Get Wikipedia article summary'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from help" -f -a "trending" -d 'Most-read Wikipedia articles (yesterday)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand wikipedia; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and not __fish_seen_subcommand_from creator-note-detail creator-notes creator-notes-summary creator-profile creator-stats download feed notifications publish search user help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and not __fish_seen_subcommand_from creator-note-detail creator-notes creator-notes-summary creator-profile creator-stats download feed notifications publish search user help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and not __fish_seen_subcommand_from creator-note-detail creator-notes creator-notes-summary creator-profile creator-stats download feed notifications publish search user help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and not __fish_seen_subcommand_from creator-note-detail creator-notes creator-notes-summary creator-profile creator-stats download feed notifications publish search user help" -f -a "creator-note-detail" -d '小红书单篇笔记详情页数据 (笔记信息 + 核心/互动数据 + 观看来源 + 观众画像 + 趋势数据)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and not __fish_seen_subcommand_from creator-note-detail creator-notes creator-notes-summary creator-profile creator-stats download feed notifications publish search user help" -f -a "creator-notes" -d '小红书创作者笔记列表 + 每篇数据 (标题/日期/观看/点赞/收藏/评论)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and not __fish_seen_subcommand_from creator-note-detail creator-notes creator-notes-summary creator-profile creator-stats download feed notifications publish search user help" -f -a "creator-notes-summary" -d '小红书最近笔记批量摘要 (列表 + 单篇关键数据汇总)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and not __fish_seen_subcommand_from creator-note-detail creator-notes creator-notes-summary creator-profile creator-stats download feed notifications publish search user help" -f -a "creator-profile" -d '小红书创作者账号信息 (粉丝/关注/获赞/成长等级)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and not __fish_seen_subcommand_from creator-note-detail creator-notes creator-notes-summary creator-profile creator-stats download feed notifications publish search user help" -f -a "creator-stats" -d '小红书创作者数据总览 (观看/点赞/收藏/评论/分享/涨粉，含每日趋势)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and not __fish_seen_subcommand_from creator-note-detail creator-notes creator-notes-summary creator-profile creator-stats download feed notifications publish search user help" -f -a "download" -d '下载小红书笔记中的图片和视频'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and not __fish_seen_subcommand_from creator-note-detail creator-notes creator-notes-summary creator-profile creator-stats download feed notifications publish search user help" -f -a "feed" -d '小红书首页推荐 Feed (via Pinia Store Action)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and not __fish_seen_subcommand_from creator-note-detail creator-notes creator-notes-summary creator-profile creator-stats download feed notifications publish search user help" -f -a "notifications" -d '小红书通知 (mentions/likes/connections)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and not __fish_seen_subcommand_from creator-note-detail creator-notes creator-notes-summary creator-profile creator-stats download feed notifications publish search user help" -f -a "publish" -d '小红书发布图文笔记 (creator center UI automation)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and not __fish_seen_subcommand_from creator-note-detail creator-notes creator-notes-summary creator-profile creator-stats download feed notifications publish search user help" -f -a "search" -d '搜索小红书笔记'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and not __fish_seen_subcommand_from creator-note-detail creator-notes creator-notes-summary creator-profile creator-stats download feed notifications publish search user help" -f -a "user" -d 'Get public notes from a Xiaohongshu user profile'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and not __fish_seen_subcommand_from creator-note-detail creator-notes creator-notes-summary creator-profile creator-stats download feed notifications publish search user help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from creator-note-detail" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from creator-note-detail" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from creator-note-detail" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from creator-notes" -l limit -d 'Number of notes to return' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from creator-notes" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from creator-notes" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from creator-notes" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from creator-notes-summary" -l limit -d 'Number of recent notes to summarize' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from creator-notes-summary" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from creator-notes-summary" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from creator-notes-summary" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from creator-profile" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from creator-profile" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from creator-profile" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from creator-stats" -l period -d 'Stats period: seven or thirty' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from creator-stats" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from creator-stats" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from creator-stats" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from download" -l output -d 'Output directory' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from download" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from download" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from download" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from feed" -l limit -d 'Number of items to return' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from feed" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from feed" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from feed" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from notifications" -l limit -d 'Number of notifications to return' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from notifications" -l type -d 'Notification type: mentions, likes, or connections' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from notifications" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from notifications" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from notifications" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from publish" -l draft -d '保存为草稿，不直接发布' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from publish" -l images -d '图片路径，逗号分隔，最多9张 (jpg/png/gif/webp)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from publish" -l title -d '笔记标题 (最多20字)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from publish" -l topics -d '话题标签，逗号分隔，不含 # 号' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from publish" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from publish" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from publish" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from search" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from user" -l limit -d 'Number of notes to return' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from user" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from user" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from user" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from help" -f -a "creator-note-detail" -d '小红书单篇笔记详情页数据 (笔记信息 + 核心/互动数据 + 观看来源 + 观众画像 + 趋势数据)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from help" -f -a "creator-notes" -d '小红书创作者笔记列表 + 每篇数据 (标题/日期/观看/点赞/收藏/评论)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from help" -f -a "creator-notes-summary" -d '小红书最近笔记批量摘要 (列表 + 单篇关键数据汇总)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from help" -f -a "creator-profile" -d '小红书创作者账号信息 (粉丝/关注/获赞/成长等级)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from help" -f -a "creator-stats" -d '小红书创作者数据总览 (观看/点赞/收藏/评论/分享/涨粉，含每日趋势)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from help" -f -a "download" -d '下载小红书笔记中的图片和视频'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from help" -f -a "feed" -d '小红书首页推荐 Feed (via Pinia Store Action)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from help" -f -a "notifications" -d '小红书通知 (mentions/likes/connections)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from help" -f -a "publish" -d '小红书发布图文笔记 (creator center UI automation)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from help" -f -a "search" -d '搜索小红书笔记'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from help" -f -a "user" -d 'Get public notes from a Xiaohongshu user profile'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaohongshu; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and not __fish_seen_subcommand_from episode podcast podcast-episodes help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and not __fish_seen_subcommand_from episode podcast podcast-episodes help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and not __fish_seen_subcommand_from episode podcast podcast-episodes help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and not __fish_seen_subcommand_from episode podcast podcast-episodes help" -f -a "episode" -d 'View details of a Xiaoyuzhou podcast episode'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and not __fish_seen_subcommand_from episode podcast podcast-episodes help" -f -a "podcast" -d 'View a Xiaoyuzhou podcast profile'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and not __fish_seen_subcommand_from episode podcast podcast-episodes help" -f -a "podcast-episodes" -d 'List recent episodes of a Xiaoyuzhou podcast (up to 15, SSR limit)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and not __fish_seen_subcommand_from episode podcast podcast-episodes help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and __fish_seen_subcommand_from episode" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and __fish_seen_subcommand_from episode" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and __fish_seen_subcommand_from episode" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and __fish_seen_subcommand_from podcast" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and __fish_seen_subcommand_from podcast" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and __fish_seen_subcommand_from podcast" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and __fish_seen_subcommand_from podcast-episodes" -l limit -d 'Max episodes to show (up to 15, SSR limit)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and __fish_seen_subcommand_from podcast-episodes" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and __fish_seen_subcommand_from podcast-episodes" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and __fish_seen_subcommand_from podcast-episodes" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and __fish_seen_subcommand_from help" -f -a "episode" -d 'View details of a Xiaoyuzhou podcast episode'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and __fish_seen_subcommand_from help" -f -a "podcast" -d 'View a Xiaoyuzhou podcast profile'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and __fish_seen_subcommand_from help" -f -a "podcast-episodes" -d 'List recent episodes of a Xiaoyuzhou podcast (up to 15, SSR limit)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xiaoyuzhou; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and not __fish_seen_subcommand_from earnings-date feed hot hot-stock search stock watchlist help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and not __fish_seen_subcommand_from earnings-date feed hot hot-stock search stock watchlist help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and not __fish_seen_subcommand_from earnings-date feed hot hot-stock search stock watchlist help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and not __fish_seen_subcommand_from earnings-date feed hot hot-stock search stock watchlist help" -f -a "earnings-date" -d '获取股票预计财报发布日期（公司大事）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and not __fish_seen_subcommand_from earnings-date feed hot hot-stock search stock watchlist help" -f -a "feed" -d '获取雪球首页时间线（关注用户的动态）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and not __fish_seen_subcommand_from earnings-date feed hot hot-stock search stock watchlist help" -f -a "hot" -d '获取雪球热门动态'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and not __fish_seen_subcommand_from earnings-date feed hot hot-stock search stock watchlist help" -f -a "hot-stock" -d '获取雪球热门股票榜'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and not __fish_seen_subcommand_from earnings-date feed hot hot-stock search stock watchlist help" -f -a "search" -d '搜索雪球股票（代码或名称）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and not __fish_seen_subcommand_from earnings-date feed hot hot-stock search stock watchlist help" -f -a "stock" -d '获取雪球股票实时行情'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and not __fish_seen_subcommand_from earnings-date feed hot hot-stock search stock watchlist help" -f -a "watchlist" -d '获取雪球自选股列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and not __fish_seen_subcommand_from earnings-date feed hot hot-stock search stock watchlist help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from earnings-date" -l limit -d '返回数量，默认 10' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from earnings-date" -l next -d '仅返回最近一次未发布的财报日期' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from earnings-date" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from earnings-date" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from earnings-date" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from feed" -l limit -d '每页数量，默认 20' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from feed" -l page -d '页码，默认 1' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from feed" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from feed" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from feed" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from hot" -l limit -d '返回数量，默认 20，最大 50' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from hot" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from hot" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from hot" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from hot-stock" -l limit -d '返回数量，默认 20，最大 50' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from hot-stock" -l type -d '榜单类型 10=人气榜(默认) 12=关注榜' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from hot-stock" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from hot-stock" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from hot-stock" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from search" -l limit -d '返回数量，默认 10' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from stock" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from stock" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from stock" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from watchlist" -l category -d '分类：1=自选(默认) 2=持仓 3=关注' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from watchlist" -l limit -d '默认 100' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from watchlist" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from watchlist" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from watchlist" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from help" -f -a "earnings-date" -d '获取股票预计财报发布日期（公司大事）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from help" -f -a "feed" -d '获取雪球首页时间线（关注用户的动态）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from help" -f -a "hot" -d '获取雪球热门动态'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from help" -f -a "hot-stock" -d '获取雪球热门股票榜'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from help" -f -a "search" -d '搜索雪球股票（代码或名称）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from help" -f -a "stock" -d '获取雪球股票实时行情'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from help" -f -a "watchlist" -d '获取雪球自选股列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand xueqiu; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yahoo-finance; and not __fish_seen_subcommand_from quote help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yahoo-finance; and not __fish_seen_subcommand_from quote help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yahoo-finance; and not __fish_seen_subcommand_from quote help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yahoo-finance; and not __fish_seen_subcommand_from quote help" -f -a "quote" -d 'Yahoo Finance 股票行情'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yahoo-finance; and not __fish_seen_subcommand_from quote help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yahoo-finance; and __fish_seen_subcommand_from quote" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yahoo-finance; and __fish_seen_subcommand_from quote" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yahoo-finance; and __fish_seen_subcommand_from quote" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yahoo-finance; and __fish_seen_subcommand_from help" -f -a "quote" -d 'Yahoo Finance 股票行情'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yahoo-finance; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and not __fish_seen_subcommand_from background edit face-swap generate models object-remover remove-bg restore try-on upload upscale video help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and not __fish_seen_subcommand_from background edit face-swap generate models object-remover remove-bg restore try-on upload upscale video help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and not __fish_seen_subcommand_from background edit face-swap generate models object-remover remove-bg restore try-on upload upscale video help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and not __fish_seen_subcommand_from background edit face-swap generate models object-remover remove-bg restore try-on upload upscale video help" -f -a "background" -d 'Generate AI background for a product/object image (5 credits)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and not __fish_seen_subcommand_from background edit face-swap generate models object-remover remove-bg restore try-on upload upscale video help" -f -a "edit" -d 'Yollomi AI edit'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and not __fish_seen_subcommand_from background edit face-swap generate models object-remover remove-bg restore try-on upload upscale video help" -f -a "face-swap" -d 'Yollomi AI face-swap'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and not __fish_seen_subcommand_from background edit face-swap generate models object-remover remove-bg restore try-on upload upscale video help" -f -a "generate" -d 'Generate images with AI (text-to-image or image-to-image)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and not __fish_seen_subcommand_from background edit face-swap generate models object-remover remove-bg restore try-on upload upscale video help" -f -a "models" -d 'List available Yollomi AI models (image, video, tools)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and not __fish_seen_subcommand_from background edit face-swap generate models object-remover remove-bg restore try-on upload upscale video help" -f -a "object-remover" -d 'Yollomi AI object-remover'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and not __fish_seen_subcommand_from background edit face-swap generate models object-remover remove-bg restore try-on upload upscale video help" -f -a "remove-bg" -d 'Yollomi AI remove-bg'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and not __fish_seen_subcommand_from background edit face-swap generate models object-remover remove-bg restore try-on upload upscale video help" -f -a "restore" -d 'Yollomi AI restore'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and not __fish_seen_subcommand_from background edit face-swap generate models object-remover remove-bg restore try-on upload upscale video help" -f -a "try-on" -d 'Yollomi AI try-on'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and not __fish_seen_subcommand_from background edit face-swap generate models object-remover remove-bg restore try-on upload upscale video help" -f -a "upload" -d 'Upload an image or video to Yollomi (returns URL for other commands)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and not __fish_seen_subcommand_from background edit face-swap generate models object-remover remove-bg restore try-on upload upscale video help" -f -a "upscale" -d 'Yollomi AI upscale'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and not __fish_seen_subcommand_from background edit face-swap generate models object-remover remove-bg restore try-on upload upscale video help" -f -a "video" -d 'Generate videos with AI (text-to-video or image-to-video)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and not __fish_seen_subcommand_from background edit face-swap generate models object-remover remove-bg restore try-on upload upscale video help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from background" -l no-download -d 'Only show URL' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from background" -l output -d 'Output directory' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from background" -l prompt -d 'Background description (optional)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from background" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from background" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from background" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from edit" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from edit" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from edit" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from face-swap" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from face-swap" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from face-swap" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from generate" -l image -d 'Input image URL for image-to-image' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from generate" -l model -d 'Model name' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from generate" -l no-download -d 'Only show URL' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from generate" -l output -d 'Output directory' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from generate" -l ratio -d 'Aspect ratio' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from generate" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from generate" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from generate" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from models" -l type -d 'Filter by model type' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from models" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from models" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from models" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from object-remover" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from object-remover" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from object-remover" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from remove-bg" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from remove-bg" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from remove-bg" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from restore" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from restore" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from restore" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from try-on" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from try-on" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from try-on" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from upload" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from upload" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from upload" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from upscale" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from upscale" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from upscale" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from video" -l image -d 'Input image URL for image-to-video' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from video" -l model -d 'Model (kling-2-1, openai-sora-2, etc.)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from video" -l no-download -d 'Only show URL, skip download' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from video" -l output -d 'Output directory' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from video" -l ratio -d 'Aspect ratio' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from video" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from video" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from video" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from help" -f -a "background" -d 'Generate AI background for a product/object image (5 credits)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from help" -f -a "edit" -d 'Yollomi AI edit'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from help" -f -a "face-swap" -d 'Yollomi AI face-swap'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from help" -f -a "generate" -d 'Generate images with AI (text-to-image or image-to-image)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from help" -f -a "models" -d 'List available Yollomi AI models (image, video, tools)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from help" -f -a "object-remover" -d 'Yollomi AI object-remover'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from help" -f -a "remove-bg" -d 'Yollomi AI remove-bg'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from help" -f -a "restore" -d 'Yollomi AI restore'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from help" -f -a "try-on" -d 'Yollomi AI try-on'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from help" -f -a "upload" -d 'Upload an image or video to Yollomi (returns URL for other commands)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from help" -f -a "upscale" -d 'Yollomi AI upscale'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from help" -f -a "video" -d 'Generate videos with AI (text-to-video or image-to-video)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand yollomi; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and not __fish_seen_subcommand_from search transcript transcript-group video help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and not __fish_seen_subcommand_from search transcript transcript-group video help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and not __fish_seen_subcommand_from search transcript transcript-group video help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and not __fish_seen_subcommand_from search transcript transcript-group video help" -f -a "search" -d 'Search YouTube videos'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and not __fish_seen_subcommand_from search transcript transcript-group video help" -f -a "transcript" -d 'Get YouTube video transcript/subtitles'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and not __fish_seen_subcommand_from search transcript transcript-group video help" -f -a "transcript-group" -d 'Get YouTube transcript with speaker detection and chapter support'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and not __fish_seen_subcommand_from search transcript transcript-group video help" -f -a "video" -d 'Get YouTube video metadata (title, views, description, etc.)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and not __fish_seen_subcommand_from search transcript transcript-group video help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from search" -l limit -d 'Max results (max 50)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from transcript" -l lang -d 'Language code (e.g. en, zh-Hans). Omit to auto-select' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from transcript" -l mode -d 'Output mode: grouped (readable paragraphs) or raw (every segment)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from transcript" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from transcript" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from transcript" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from transcript-group" -l lang -d 'Language code (e.g. en, zh-Hans). Omit to auto-select' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from transcript-group" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from transcript-group" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from transcript-group" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from video" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from video" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from video" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search YouTube videos'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from help" -f -a "transcript" -d 'Get YouTube video transcript/subtitles'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from help" -f -a "transcript-group" -d 'Get YouTube transcript with speaker detection and chapter support'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from help" -f -a "video" -d 'Get YouTube video metadata (title, views, description, etc.)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand youtube; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and not __fish_seen_subcommand_from download hot question search help" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and not __fish_seen_subcommand_from download hot question search help" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and not __fish_seen_subcommand_from download hot question search help" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and not __fish_seen_subcommand_from download hot question search help" -f -a "download" -d '导出知乎文章为 Markdown 格式'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and not __fish_seen_subcommand_from download hot question search help" -f -a "hot" -d '知乎热榜'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and not __fish_seen_subcommand_from download hot question search help" -f -a "question" -d '知乎问题详情和回答'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and not __fish_seen_subcommand_from download hot question search help" -f -a "search" -d '知乎搜索'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and not __fish_seen_subcommand_from download hot question search help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from download" -l output -d 'Output directory' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from download" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from download" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from download" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from hot" -l limit -d 'Number of items to return' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from hot" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from hot" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from hot" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from question" -l limit -d 'Number of answers' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from question" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from question" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from question" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from search" -l limit -d 'Number of results' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from search" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from search" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from help" -f -a "download" -d '导出知乎文章为 Markdown 格式'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from help" -f -a "hot" -d '知乎热榜'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from help" -f -a "question" -d '知乎问题详情和回答'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from help" -f -a "search" -d '知乎搜索'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand zhihu; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand gh" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand gh" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand gh" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand obsidian" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand obsidian" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand obsidian" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand readwise" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand readwise" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand readwise" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand kubectl" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand kubectl" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand kubectl" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand docker" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand docker" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand docker" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand gws" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand gws" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand gws" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doctor" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doctor" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand doctor" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand completion" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand completion" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand completion" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand explore" -l site -d 'Override site name' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand explore" -l goal -d 'Hint for capability naming (e.g. search, hot)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand explore" -l wait -d 'Initial wait seconds' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand explore" -l click -d 'Comma-separated labels to click before fuzzing (e.g. \'Comments,CC,字幕\')' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand explore" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand explore" -l auto -d 'Enable interactive fuzzing (click buttons/tabs to trigger hidden APIs)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand explore" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand explore" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cascade" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cascade" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand cascade" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand generate" -l goal -d 'What you want (e.g. hot, search, trending)' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand generate" -l site -d 'Override site name' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand generate" -s f -l format -d 'Output format: table, json, yaml, csv, md' -r
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand generate" -s v -l verbose -d 'Enable verbose output'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand generate" -s h -l help -d 'Print help'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "antigravity"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "apple-podcasts"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "arxiv"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "barchart"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "bbc"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "bilibili"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "bloomberg"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "boss"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "chaoxing"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "chatgpt"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "chatwise"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "codex"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "coupang"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "ctrip"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "cursor"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "devto"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "discord-app"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "douban"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "doubao"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "doubao-app"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "facebook"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "google"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "grok"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "hackernews"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "hf"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "instagram"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "jike"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "jimeng"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "linkedin"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "linux-do"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "lobsters"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "medium"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "notion"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "reddit"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "reuters"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "sinablog"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "sinafinance"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "smzdm"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "stackoverflow"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "steam"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "substack"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "tiktok"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "twitter"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "v2ex"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "weibo"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "weixin"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "weread"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "wikipedia"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "xiaohongshu"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "xiaoyuzhou"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "xueqiu"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "yahoo-finance"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "yollomi"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "youtube"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "zhihu"
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "gh" -d 'GitHub CLI — repos, PRs, issues, releases, gists'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "obsidian" -d 'Obsidian vault management — notes, search, tags, tasks, sync'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "readwise" -d 'Readwise & Reader CLI — highlights, annotations, reading list'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "kubectl" -d 'Kubernetes command-line tool'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "docker" -d 'Docker command-line interface'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "gws" -d 'Google Workspace CLI — Docs, Sheets, Drive, Gmail, Calendar'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "doctor" -d 'Run diagnostics checks'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "completion" -d 'Generate shell completions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "explore" -d 'Explore a website\'s API surface and discover endpoints'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "cascade" -d 'Auto-detect authentication strategy for an API endpoint'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "generate" -d 'One-shot: explore + synthesize + select best adapter'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and not __fish_seen_subcommand_from antigravity apple-podcasts arxiv barchart bbc bilibili bloomberg boss chaoxing chatgpt chatwise codex coupang ctrip cursor devto discord-app douban doubao doubao-app facebook google grok hackernews hf instagram jike jimeng linkedin linux-do lobsters medium notion reddit reuters sinablog sinafinance smzdm stackoverflow steam substack tiktok twitter v2ex weibo weixin weread wikipedia xiaohongshu xiaoyuzhou xueqiu yahoo-finance yollomi youtube zhihu gh obsidian readwise kubectl docker gws doctor completion explore cascade generate help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from antigravity" -f -a "dump" -d 'Dump the DOM to help AI understand the UI'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from antigravity" -f -a "extract-code" -d 'Extract multi-line code blocks from the current Antigravity conversation'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from antigravity" -f -a "model" -d 'Get or change the active AI model in Antigravity'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from antigravity" -f -a "new" -d 'Start a new Antigravity conversation'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from antigravity" -f -a "read" -d 'Read the current Antigravity conversation'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from antigravity" -f -a "send" -d 'Send a message to Antigravity'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from antigravity" -f -a "serve" -d 'Check if Antigravity is being served / accessible'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from antigravity" -f -a "status" -d 'Check active CDP connection to Antigravity'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from antigravity" -f -a "watch" -d 'Watch for new messages in Antigravity conversation'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from apple-podcasts" -f -a "episodes" -d 'List recent episodes of an Apple Podcast (use ID from search)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from apple-podcasts" -f -a "search" -d 'Search Apple Podcasts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from apple-podcasts" -f -a "top" -d 'Top podcasts chart on Apple Podcasts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from arxiv" -f -a "paper" -d 'Get arXiv paper details by ID'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from arxiv" -f -a "search" -d 'Search arXiv papers'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from barchart" -f -a "flow" -d 'Barchart unusual options activity / options flow'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from barchart" -f -a "greeks" -d 'Barchart options greeks overview (IV, delta, gamma, theta, vega)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from barchart" -f -a "options" -d 'Barchart options chain with greeks, IV, volume, and open interest'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from barchart" -f -a "quote" -d 'Barchart stock quote with price, volume, and key metrics'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bbc" -f -a "news" -d 'BBC News headlines (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bilibili" -f -a "download" -d '下载B站视频（需要 yt-dlp）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bilibili" -f -a "dynamic" -d 'Get Bilibili user dynamic feed'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bilibili" -f -a "favorite" -d '我的默认收藏夹'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bilibili" -f -a "feed" -d '关注的人的动态时间线'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bilibili" -f -a "following" -d '获取 Bilibili 用户的关注列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bilibili" -f -a "history" -d '我的观看历史'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bilibili" -f -a "hot" -d 'B站热门视频'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bilibili" -f -a "me" -d 'My Bilibili profile info'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bilibili" -f -a "ranking" -d 'Get Bilibili video ranking board'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bilibili" -f -a "search" -d 'Search Bilibili videos or users'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bilibili" -f -a "subtitle" -d '获取 Bilibili 视频的字幕'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bilibili" -f -a "user-videos" -d '查看指定用户的投稿视频'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bloomberg" -f -a "businessweek" -d 'Bloomberg Businessweek top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bloomberg" -f -a "economics" -d 'Bloomberg Economics top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bloomberg" -f -a "feeds" -d 'List the Bloomberg RSS feed aliases used by the adapter'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bloomberg" -f -a "industries" -d 'Bloomberg Industries top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bloomberg" -f -a "main" -d 'Bloomberg homepage top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bloomberg" -f -a "markets" -d 'Bloomberg Markets top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bloomberg" -f -a "news" -d 'Read a Bloomberg story/article page and return title, full content, and media links'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bloomberg" -f -a "opinions" -d 'Bloomberg Opinion top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bloomberg" -f -a "politics" -d 'Bloomberg Politics top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from bloomberg" -f -a "tech" -d 'Bloomberg Tech top stories (RSS)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from boss" -f -a "batchgreet" -d 'BOSS直聘批量向推荐候选人发送招呼'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from boss" -f -a "chatlist" -d 'BOSS直聘查看聊天列表（招聘端）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from boss" -f -a "chatmsg" -d 'BOSS直聘查看与候选人的聊天消息'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from boss" -f -a "detail" -d 'BOSS直聘查看职位详情'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from boss" -f -a "exchange" -d 'BOSS直聘交换联系方式（请求手机/微信）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from boss" -f -a "greet" -d 'BOSS直聘向新候选人发送招呼（开始聊天）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from boss" -f -a "invite" -d 'BOSS直聘发送面试邀请'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from boss" -f -a "joblist" -d 'BOSS直聘查看我发布的职位列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from boss" -f -a "mark" -d 'BOSS直聘给候选人添加标签'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from boss" -f -a "recommend" -d 'BOSS直聘查看推荐候选人（新招呼列表）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from boss" -f -a "resume" -d 'BOSS直聘查看候选人简历（招聘端）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from boss" -f -a "search" -d 'BOSS直聘搜索职位'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from boss" -f -a "send" -d 'BOSS直聘发送聊天消息'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from boss" -f -a "stats" -d 'BOSS直聘职位数据统计'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from chaoxing" -f -a "assignments" -d '学习通作业列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from chaoxing" -f -a "exams" -d '学习通考试列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from chatgpt" -f -a "ask" -d 'Send a prompt and wait for the AI response (macOS ChatGPT desktop app)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from chatgpt" -f -a "ax" -d 'Read visible chat messages from ChatGPT Desktop via macOS Accessibility API'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from chatgpt" -f -a "new" -d 'Open a new chat in ChatGPT Desktop App'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from chatgpt" -f -a "read" -d 'Read the last visible message from the focused ChatGPT Desktop window'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from chatgpt" -f -a "send" -d 'Send a message to the active ChatGPT Desktop App window'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from chatgpt" -f -a "status" -d 'Check if ChatGPT Desktop App is running natively on macOS'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from chatwise" -f -a "ask" -d 'Send a prompt and wait for the AI response (send + wait + read)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from chatwise" -f -a "export" -d 'Export the current ChatWise conversation to a Markdown file'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from chatwise" -f -a "history" -d 'List conversation history in ChatWise sidebar'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from chatwise" -f -a "model" -d 'Get or switch the active AI model in ChatWise'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from chatwise" -f -a "new" -d 'Start a new conversation in ChatWise'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from chatwise" -f -a "read" -d 'Read the current ChatWise conversation history'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from chatwise" -f -a "screenshot" -d 'Capture a snapshot of the current ChatWise window (DOM + Accessibility tree)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from chatwise" -f -a "send" -d 'Send a message to the active ChatWise conversation'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from chatwise" -f -a "status" -d 'Check active CDP connection to ChatWise Desktop'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from codex" -f -a "ask" -d 'Send a prompt and wait for the AI response (send + wait + read)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from codex" -f -a "dump" -d 'Dump the DOM and Accessibility tree of Codex for reverse-engineering'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from codex" -f -a "export" -d 'Export the current Codex conversation to a Markdown file'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from codex" -f -a "extract-diff" -d 'Extract visual code review diff patches from Codex'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from codex" -f -a "history" -d 'List recent conversation threads in Codex'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from codex" -f -a "model" -d 'Get or switch the currently active AI model in Codex Desktop'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from codex" -f -a "new" -d 'Start a new Codex conversation thread / isolated workspace'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from codex" -f -a "read" -d 'Read the contents of the current Codex conversation thread'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from codex" -f -a "screenshot" -d 'Capture a snapshot of the current Codex window (DOM + Accessibility tree)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from codex" -f -a "send" -d 'Send text/commands to the Codex AI composer'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from codex" -f -a "status" -d 'Check active CDP connection to OpenAI Codex App'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from coupang" -f -a "add-to-cart" -d 'Add a Coupang product to cart using logged-in browser session'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from coupang" -f -a "search" -d 'Search Coupang products with logged-in browser session'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from ctrip" -f -a "search" -d '携程旅行搜索'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from cursor" -f -a "ask" -d 'Send a prompt and wait for the AI response (send + wait + read)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from cursor" -f -a "composer" -d 'Send a prompt directly into Cursor Composer (Cmd+I shortcut)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from cursor" -f -a "dump" -d 'Dump the DOM and Accessibility tree of Cursor for reverse-engineering'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from cursor" -f -a "export" -d 'Export the current Cursor conversation to Markdown'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from cursor" -f -a "extract-code" -d 'Extract multi-line code blocks from the current Cursor conversation'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from cursor" -f -a "history" -d 'List recent chat sessions from the Cursor sidebar'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from cursor" -f -a "model" -d 'Get or switch the currently active AI model in Cursor'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from cursor" -f -a "new" -d 'Start a new Cursor chat or Composer session'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from cursor" -f -a "read" -d 'Read the current Cursor chat/composer conversation history'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from cursor" -f -a "screenshot" -d 'Capture a snapshot of the current Cursor window (DOM + Accessibility tree)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from cursor" -f -a "send" -d 'Send a prompt directly into Cursor Composer/Chat'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from cursor" -f -a "status" -d 'Check active CDP connection to Cursor AI Editor'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from devto" -f -a "tag" -d 'Latest DEV.to articles for a specific tag'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from devto" -f -a "top" -d 'Top DEV.to articles of the day'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from devto" -f -a "user" -d 'Recent DEV.to articles from a specific user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from discord-app" -f -a "channels" -d 'List channels in the current Discord server'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from discord-app" -f -a "members" -d 'List online members in the current Discord channel'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from discord-app" -f -a "read" -d 'Read recent messages from the active Discord channel'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from discord-app" -f -a "search" -d 'Search messages in the current Discord server/channel'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from discord-app" -f -a "send" -d 'Send a message in the active Discord channel'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from discord-app" -f -a "servers" -d 'List all Discord servers (guilds) in the sidebar'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from discord-app" -f -a "status" -d 'Check active CDP connection to Discord Desktop'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from douban" -f -a "book-hot" -d '豆瓣图书热门榜单'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from douban" -f -a "marks" -d '导出个人观影标记'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from douban" -f -a "movie-hot" -d '豆瓣电影热门榜单'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from douban" -f -a "reviews" -d '导出个人影评'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from douban" -f -a "search" -d '搜索豆瓣电影、图书或音乐'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from douban" -f -a "subject" -d '获取电影详情'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from douban" -f -a "top250" -d '豆瓣电影 Top250'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from doubao" -f -a "ask" -d 'Send a prompt and wait for the Doubao response'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from doubao" -f -a "new" -d 'Start a new conversation in Doubao web chat'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from doubao" -f -a "read" -d 'Read the current Doubao conversation history'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from doubao" -f -a "send" -d 'Send a message to Doubao web chat'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from doubao" -f -a "status" -d 'Check Doubao chat page availability and login state'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from doubao-app" -f -a "ask" -d 'Send a message to Doubao desktop app and wait for the AI response'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from doubao-app" -f -a "dump" -d 'Dump Doubao desktop app DOM and snapshot to /tmp for debugging'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from doubao-app" -f -a "new" -d 'Start a new chat in Doubao desktop app'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from doubao-app" -f -a "read" -d 'Read chat history from Doubao desktop app'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from doubao-app" -f -a "screenshot" -d 'Capture a screenshot of the Doubao desktop app window'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from doubao-app" -f -a "send" -d 'Send a message to Doubao desktop app'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from doubao-app" -f -a "status" -d 'Check CDP connection to Doubao desktop app'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from facebook" -f -a "add-friend" -d 'Send a friend request on Facebook'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from facebook" -f -a "events" -d 'Browse Facebook event categories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from facebook" -f -a "feed" -d 'Get your Facebook news feed'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from facebook" -f -a "friends" -d 'Get Facebook friend suggestions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from facebook" -f -a "groups" -d 'List your Facebook groups'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from facebook" -f -a "join-group" -d 'Join a Facebook group'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from facebook" -f -a "memories" -d 'Get your Facebook memories (On This Day)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from facebook" -f -a "notifications" -d 'Get recent Facebook notifications'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from facebook" -f -a "profile" -d 'Get Facebook user/page profile info'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from facebook" -f -a "search" -d 'Search Facebook for people, pages, or posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from google" -f -a "news" -d 'Get Google News headlines'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from google" -f -a "search" -d 'Search Google'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from google" -f -a "suggest" -d 'Get Google search suggestions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from google" -f -a "trends" -d 'Get Google Trends daily trending searches'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from grok" -f -a "ask" -d 'Send a message to Grok and get response'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from hackernews" -f -a "ask" -d 'Hacker News Ask HN posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from hackernews" -f -a "best" -d 'Hacker News best stories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from hackernews" -f -a "jobs" -d 'Hacker News job postings'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from hackernews" -f -a "new" -d 'Hacker News newest stories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from hackernews" -f -a "search" -d 'Search Hacker News stories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from hackernews" -f -a "show" -d 'Hacker News Show HN posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from hackernews" -f -a "top" -d 'Hacker News top stories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from hackernews" -f -a "user" -d 'Hacker News user profile'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from hf" -f -a "top" -d 'Top upvoted Hugging Face papers'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from instagram" -f -a "comment" -d 'Comment on an Instagram post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from instagram" -f -a "explore" -d 'Instagram explore/discover trending posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from instagram" -f -a "follow" -d 'Follow an Instagram user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from instagram" -f -a "followers" -d 'List followers of an Instagram user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from instagram" -f -a "following" -d 'List accounts an Instagram user is following'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from instagram" -f -a "like" -d 'Like an Instagram post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from instagram" -f -a "profile" -d 'Get Instagram user profile info'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from instagram" -f -a "save" -d 'Save (bookmark) an Instagram post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from instagram" -f -a "saved" -d 'Get your saved Instagram posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from instagram" -f -a "search" -d 'Search Instagram users'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from instagram" -f -a "unfollow" -d 'Unfollow an Instagram user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from instagram" -f -a "unlike" -d 'Unlike an Instagram post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from instagram" -f -a "unsave" -d 'Unsave (remove bookmark) an Instagram post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from instagram" -f -a "user" -d 'Get recent posts from an Instagram user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from jike" -f -a "comment" -d '评论即刻帖子'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from jike" -f -a "create" -d '发布即刻动态'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from jike" -f -a "feed" -d '即刻首页动态流'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from jike" -f -a "like" -d '点赞即刻帖子'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from jike" -f -a "notifications" -d '即刻通知'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from jike" -f -a "post" -d '即刻帖子详情及评论'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from jike" -f -a "repost" -d '转发即刻帖子'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from jike" -f -a "search" -d '搜索即刻帖子'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from jike" -f -a "topic" -d '即刻话题/圈子帖子'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from jike" -f -a "user" -d '即刻用户动态'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from jimeng" -f -a "generate" -d '即梦AI 文生图 — 输入 prompt 生成图片'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from jimeng" -f -a "history" -d '即梦AI 查看最近生成的作品'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from linkedin" -f -a "search" -d 'Search LinkedIn jobs'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from linux-do" -f -a "categories" -d 'linux.do 分类列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from linux-do" -f -a "category" -d 'linux.do 分类内话题'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from linux-do" -f -a "hot" -d 'linux.do 热门话题'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from linux-do" -f -a "latest" -d 'linux.do 最新话题'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from linux-do" -f -a "search" -d '搜索 linux.do'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from linux-do" -f -a "topic" -d 'linux.do 帖子详情和回复（首页）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from lobsters" -f -a "active" -d 'Lobste.rs most active discussions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from lobsters" -f -a "hot" -d 'Lobste.rs hottest stories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from lobsters" -f -a "newest" -d 'Lobste.rs newest stories'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from lobsters" -f -a "tag" -d 'Lobste.rs stories by tag'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from medium" -f -a "feed" -d 'Medium 热门文章 Feed'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from medium" -f -a "search" -d '搜索 Medium 文章'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from medium" -f -a "user" -d '获取 Medium 用户的文章列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from notion" -f -a "export" -d 'Export the current Notion page as Markdown'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from notion" -f -a "favorites" -d 'List pages from the Notion Favorites section in the sidebar'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from notion" -f -a "new" -d 'Create a new page in Notion'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from notion" -f -a "read" -d 'Read the content of the currently open Notion page'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from notion" -f -a "search" -d 'Search pages and databases in Notion via Quick Find (Cmd+P)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from notion" -f -a "sidebar" -d 'List pages and databases from the Notion sidebar'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from notion" -f -a "status" -d 'Check active CDP connection to Notion Desktop'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from notion" -f -a "write" -d 'Append text content to the currently open Notion page'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from reddit" -f -a "comment" -d 'Post a comment on a Reddit post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from reddit" -f -a "frontpage" -d 'Reddit Frontpage / r/all'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from reddit" -f -a "hot" -d 'Reddit 热门帖子'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from reddit" -f -a "popular" -d 'Reddit Popular posts (/r/popular)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from reddit" -f -a "read" -d 'Read a Reddit post and its comments'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from reddit" -f -a "save" -d 'Save or unsave a Reddit post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from reddit" -f -a "saved" -d 'Browse your saved Reddit posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from reddit" -f -a "search" -d 'Search Reddit Posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from reddit" -f -a "subreddit" -d 'Get posts from a specific Subreddit'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from reddit" -f -a "subscribe" -d 'Subscribe or unsubscribe to a subreddit'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from reddit" -f -a "upvote" -d 'Upvote or downvote a Reddit post'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from reddit" -f -a "upvoted" -d 'Browse your upvoted Reddit posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from reddit" -f -a "user" -d 'View a Reddit user profile'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from reddit" -f -a "user-comments" -d 'View a Reddit user\'s comment history'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from reddit" -f -a "user-posts" -d 'View a Reddit user\'s submitted posts'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from reuters" -f -a "search" -d 'Reuters 路透社新闻搜索'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from sinablog" -f -a "article" -d '获取新浪博客单篇文章详情'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from sinablog" -f -a "hot" -d '获取新浪博客热门文章/推荐'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from sinablog" -f -a "search" -d '搜索新浪博客文章（通过新浪搜索）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from sinablog" -f -a "user" -d '获取新浪博客用户的文章列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from sinafinance" -f -a "news" -d '新浪财经 7x24 小时实时快讯'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from smzdm" -f -a "search" -d '什么值得买搜索好价'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from stackoverflow" -f -a "bounties" -d 'Active bounties on Stack Overflow'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from stackoverflow" -f -a "hot" -d 'Hot Stack Overflow questions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from stackoverflow" -f -a "search" -d 'Search Stack Overflow questions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from stackoverflow" -f -a "unanswered" -d 'Top voted unanswered questions on Stack Overflow'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from steam" -f -a "top-sellers" -d 'Steam top selling games'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from substack" -f -a "feed" -d 'Substack 热门文章 Feed'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from substack" -f -a "publication" -d '获取特定 Substack Newsletter 的最新文章'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from substack" -f -a "search" -d '搜索 Substack 文章和 Newsletter'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from tiktok" -f -a "comment" -d 'Comment on a TikTok video'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from tiktok" -f -a "explore" -d 'Get trending TikTok videos from explore page'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from tiktok" -f -a "follow" -d 'Follow a TikTok user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from tiktok" -f -a "following" -d 'List accounts you follow on TikTok'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from tiktok" -f -a "friends" -d 'Get TikTok friend suggestions'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from tiktok" -f -a "like" -d 'Like a TikTok video'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from tiktok" -f -a "live" -d 'Browse live streams on TikTok'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from tiktok" -f -a "notifications" -d 'Get TikTok notifications (likes, comments, mentions, followers)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from tiktok" -f -a "profile" -d 'Get TikTok user profile info'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from tiktok" -f -a "save" -d 'Add a TikTok video to Favorites'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from tiktok" -f -a "search" -d 'Search TikTok videos'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from tiktok" -f -a "unfollow" -d 'Unfollow a TikTok user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from tiktok" -f -a "unlike" -d 'Unlike a TikTok video'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from tiktok" -f -a "unsave" -d 'Remove a TikTok video from Favorites'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from tiktok" -f -a "user" -d 'Get recent videos from a TikTok user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "accept" -d 'Auto-accept DM requests containing specific keywords'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "article" -d 'Fetch a Twitter Article (long-form content) and export as Markdown'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "block" -d 'Block a Twitter user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "bookmark" -d 'Bookmark a tweet'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "bookmarks" -d 'Fetch Twitter/X bookmarks'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "delete" -d 'Delete a specific tweet by URL'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "download" -d '下载 Twitter/X 媒体（图片和视频）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "follow" -d 'Follow a Twitter user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "followers" -d 'Get accounts following a Twitter/X user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "following" -d 'Get accounts a Twitter/X user is following'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "hide-reply" -d 'Hide a reply on your tweet (useful for hiding bot/spam replies)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "like" -d 'Like a specific tweet'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "notifications" -d 'Get Twitter/X notifications'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "post" -d 'Post a new tweet/thread'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "profile" -d 'Fetch a Twitter user profile (bio, stats, etc.)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "reply" -d 'Reply to a specific tweet'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "reply-dm" -d 'Send a message to recent DM conversations'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "search" -d 'Search Twitter/X for tweets'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "thread" -d 'Get a tweet thread (original + all replies)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "timeline" -d 'Fetch Twitter timeline (for-you or following)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "trending" -d 'Twitter/X trending topics'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "unblock" -d 'Unblock a Twitter user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "unbookmark" -d 'Remove a tweet from bookmarks'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from twitter" -f -a "unfollow" -d 'Unfollow a Twitter user'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from v2ex" -f -a "daily" -d 'V2EX 每日签到并领取铜币'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from v2ex" -f -a "hot" -d 'V2EX 热门话题'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from v2ex" -f -a "latest" -d 'V2EX 最新话题'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from v2ex" -f -a "me" -d 'V2EX 获取个人资料 (余额/未读提醒)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from v2ex" -f -a "member" -d 'V2EX 用户资料'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from v2ex" -f -a "node" -d 'V2EX 节点话题列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from v2ex" -f -a "nodes" -d 'V2EX 所有节点列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from v2ex" -f -a "notifications" -d 'V2EX 获取提醒 (回复/感谢)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from v2ex" -f -a "replies" -d 'V2EX 主题回复列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from v2ex" -f -a "topic" -d 'V2EX 主题详情和回复'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from v2ex" -f -a "user" -d 'V2EX 用户发帖列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from weibo" -f -a "hot" -d '微博热搜'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from weibo" -f -a "search" -d '搜索微博'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from weixin" -f -a "download" -d '下载微信公众号文章为 Markdown 格式'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from weread" -f -a "book" -d 'View book details on WeRead'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from weread" -f -a "highlights" -d 'List your highlights (underlines) in a book'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from weread" -f -a "notebooks" -d 'List books that have highlights or notes'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from weread" -f -a "notes" -d 'List your notes (thoughts) on a book'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from weread" -f -a "ranking" -d 'WeRead book rankings by category'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from weread" -f -a "search" -d 'Search books on WeRead'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from weread" -f -a "shelf" -d 'List books on your WeRead bookshelf'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from wikipedia" -f -a "random" -d 'Get a random Wikipedia article'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from wikipedia" -f -a "search" -d 'Search Wikipedia articles'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from wikipedia" -f -a "summary" -d 'Get Wikipedia article summary'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from wikipedia" -f -a "trending" -d 'Most-read Wikipedia articles (yesterday)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xiaohongshu" -f -a "creator-note-detail" -d '小红书单篇笔记详情页数据 (笔记信息 + 核心/互动数据 + 观看来源 + 观众画像 + 趋势数据)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xiaohongshu" -f -a "creator-notes" -d '小红书创作者笔记列表 + 每篇数据 (标题/日期/观看/点赞/收藏/评论)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xiaohongshu" -f -a "creator-notes-summary" -d '小红书最近笔记批量摘要 (列表 + 单篇关键数据汇总)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xiaohongshu" -f -a "creator-profile" -d '小红书创作者账号信息 (粉丝/关注/获赞/成长等级)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xiaohongshu" -f -a "creator-stats" -d '小红书创作者数据总览 (观看/点赞/收藏/评论/分享/涨粉，含每日趋势)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xiaohongshu" -f -a "download" -d '下载小红书笔记中的图片和视频'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xiaohongshu" -f -a "feed" -d '小红书首页推荐 Feed (via Pinia Store Action)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xiaohongshu" -f -a "notifications" -d '小红书通知 (mentions/likes/connections)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xiaohongshu" -f -a "publish" -d '小红书发布图文笔记 (creator center UI automation)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xiaohongshu" -f -a "search" -d '搜索小红书笔记'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xiaohongshu" -f -a "user" -d 'Get public notes from a Xiaohongshu user profile'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xiaoyuzhou" -f -a "episode" -d 'View details of a Xiaoyuzhou podcast episode'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xiaoyuzhou" -f -a "podcast" -d 'View a Xiaoyuzhou podcast profile'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xiaoyuzhou" -f -a "podcast-episodes" -d 'List recent episodes of a Xiaoyuzhou podcast (up to 15, SSR limit)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xueqiu" -f -a "earnings-date" -d '获取股票预计财报发布日期（公司大事）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xueqiu" -f -a "feed" -d '获取雪球首页时间线（关注用户的动态）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xueqiu" -f -a "hot" -d '获取雪球热门动态'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xueqiu" -f -a "hot-stock" -d '获取雪球热门股票榜'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xueqiu" -f -a "search" -d '搜索雪球股票（代码或名称）'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xueqiu" -f -a "stock" -d '获取雪球股票实时行情'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from xueqiu" -f -a "watchlist" -d '获取雪球自选股列表'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from yahoo-finance" -f -a "quote" -d 'Yahoo Finance 股票行情'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from yollomi" -f -a "background" -d 'Generate AI background for a product/object image (5 credits)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from yollomi" -f -a "edit" -d 'Yollomi AI edit'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from yollomi" -f -a "face-swap" -d 'Yollomi AI face-swap'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from yollomi" -f -a "generate" -d 'Generate images with AI (text-to-image or image-to-image)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from yollomi" -f -a "models" -d 'List available Yollomi AI models (image, video, tools)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from yollomi" -f -a "object-remover" -d 'Yollomi AI object-remover'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from yollomi" -f -a "remove-bg" -d 'Yollomi AI remove-bg'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from yollomi" -f -a "restore" -d 'Yollomi AI restore'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from yollomi" -f -a "try-on" -d 'Yollomi AI try-on'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from yollomi" -f -a "upload" -d 'Upload an image or video to Yollomi (returns URL for other commands)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from yollomi" -f -a "upscale" -d 'Yollomi AI upscale'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from yollomi" -f -a "video" -d 'Generate videos with AI (text-to-video or image-to-video)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from youtube" -f -a "search" -d 'Search YouTube videos'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from youtube" -f -a "transcript" -d 'Get YouTube video transcript/subtitles'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from youtube" -f -a "transcript-group" -d 'Get YouTube transcript with speaker detection and chapter support'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from youtube" -f -a "video" -d 'Get YouTube video metadata (title, views, description, etc.)'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from zhihu" -f -a "download" -d '导出知乎文章为 Markdown 格式'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from zhihu" -f -a "hot" -d '知乎热榜'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from zhihu" -f -a "question" -d '知乎问题详情和回答'
complete -c opencli-rs -n "__fish_opencli_rs_using_subcommand help; and __fish_seen_subcommand_from zhihu" -f -a "search" -d '知乎搜索'
