# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_longbridge_global_optspecs
	string join \n format= v/verbose lang= h/help V/version
end

function __fish_longbridge_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_longbridge_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_longbridge_using_subcommand
	set -l cmd (__fish_longbridge_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c longbridge -n "__fish_longbridge_needs_command" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_needs_command" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_needs_command" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_needs_command" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_needs_command" -s V -l version -d 'Print version'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "auth" -d 'Authenticate or clear credentials'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "check" -d 'Check token validity, and API connectivity'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "update" -d 'Update longbridge to the latest version'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "tui" -d 'Launch the interactive full-screen TUI (terminal UI)'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "completion" -d 'Generate shell completion script'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "quote" -d 'Real-time quotes for one or more symbols'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "depth" -d 'Level 2 order book depth (bid/ask ladder)'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "brokers" -d 'Broker queue at each price level (HK market)'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "trades" -d 'Recent tick-by-tick trades'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "intraday" -d 'Intraday minute-by-minute price and volume lines for today (or a historical date)'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "kline" -d 'OHLCV candlestick (K-line) data, or historical date-range candlesticks'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "static" -d 'Static reference info for one or more symbols'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "calc-index" -d 'Calculated financial indexes (PE, PB, DPS rate, turnover rate, etc.)'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "capital" -d 'Intraday capital distribution snapshot, or flow time series with --flow'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "market-temp" -d 'Market sentiment temperature index (0–100, higher = more bullish)'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "trading" -d 'Trading session schedule and trading calendar'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "security-list" -d 'List of US overnight-eligible securities'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "participants" -d 'Market maker (participant) broker IDs and names'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "subscriptions" -d 'Active real-time WebSocket subscriptions for this session'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "option" -d 'Option quotes, option chain, and option volume statistics'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "warrant" -d 'Warrant quotes, warrant list, and issuer list'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "financial-report" -d 'Financial statements (income, balance sheet, cash flow) for a symbol'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "institution-rating" -d 'Institution rating overview and target price summary'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "dividend" -d 'Dividend history and distribution details for a symbol'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "forecast-eps" -d 'EPS forecasts and analyst consensus estimates for a symbol'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "consensus" -d 'Financial consensus detail for a symbol'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "finance-calendar" -d 'Finance calendar: upcoming events by type (V2)'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "valuation" -d 'Valuation analysis: P/E, P/B, P/S, dividend yield, and peer comparison'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "news" -d 'Latest news articles for a symbol, or fetch full article content'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "filing" -d 'Regulatory filings for a symbol, or list/fetch filing content'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "topic" -d 'Community discussion topics'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "watchlist" -d 'List watchlist groups, or create/update/delete a group'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "statement" -d 'Download and export account statements (daily/monthly)'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "order" -d 'Order management: list, detail, buy, sell, cancel, replace, executions'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "assets" -d 'Account asset overview — net assets, cash, buy power, margins, and per-currency breakdown'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "cash-flow" -d 'Cash flow records (deposits, withdrawals, dividends, settlements)'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "portfolio" -d 'Portfolio overview — total assets, P/L, intraday P/L, holdings, and cash breakdown'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "positions" -d 'Current stock (equity) positions across all sub-accounts'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "fund-positions" -d 'Current fund (mutual fund) positions across all sub-accounts'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "margin-ratio" -d 'Margin ratio requirements for a symbol'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "max-qty" -d 'Estimate maximum buy or sell quantity given current account balance'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "exchange-rate" -d 'Exchange rates for all supported currencies'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "shareholder" -d 'Institutional shareholders for a symbol'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "company" -d 'Company overview (founding date, employees, IPO price, address, etc.)'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "executive" -d 'Company executives and key personnel'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "industry-valuation" -d 'Industry valuation comparison and distribution'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "operating" -d 'Operating reviews and financial indicators by report period'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "corp-action" -d 'Corporate actions (splits, dividends, rights, etc.)'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "invest-relation" -d 'Investment relations (subsidiary/parent companies)'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "constituent" -d 'Index or ETF constituent stocks'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "market-status" -d 'Market open/close status for each exchange'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "broker-holding" -d 'Broker holding positions (HK market only)'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "ah-premium" -d 'A/H premium ratio for dual-listed stocks (kline or intraday)'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "trade-stats" -d 'Trade statistics (price distribution by volume)'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "anomaly" -d 'Quote anomalies / unusual market movements'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "alert" -d 'Price alerts (list, add, delete)'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "profit-analysis" -d 'Profit & loss analysis'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "fund-holder" -d 'Funds and ETFs that hold a given symbol'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "insider-trades" -d 'SEC Form 4 insider trades for a US-listed company'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "investors" -d 'View SEC 13F portfolio holdings for institutional investors'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "dca" -d 'Recurring Investment: automatically invest a fixed amount at regular intervals'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "short-positions" -d 'US stock short selling data (short interest, short ratio, days to cover)'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "sharelist" -d 'Sharelist: community stock lists — list, detail, create, delete, and manage stocks'
complete -c longbridge -n "__fish_longbridge_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and not __fish_seen_subcommand_from login logout status help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and not __fish_seen_subcommand_from login logout status help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and not __fish_seen_subcommand_from login logout status help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and not __fish_seen_subcommand_from login logout status help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and not __fish_seen_subcommand_from login logout status help" -f -a "login" -d 'Authenticate via Device Authorization Flow (default) or browser OAuth'
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and not __fish_seen_subcommand_from login logout status help" -f -a "logout" -d 'Clear the locally stored OAuth token'
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and not __fish_seen_subcommand_from login logout status help" -f -a "status" -d 'Show authentication status'
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and not __fish_seen_subcommand_from login logout status help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and __fish_seen_subcommand_from login" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and __fish_seen_subcommand_from login" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and __fish_seen_subcommand_from login" -l auth-code -d 'Authorization Code flow: opens a browser and handles the localhost callback. Requires the browser to be on the same machine (local use only)'
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and __fish_seen_subcommand_from login" -s v -l verbose -d 'Print request/response details for each OAuth step'
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and __fish_seen_subcommand_from login" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and __fish_seen_subcommand_from logout" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and __fish_seen_subcommand_from logout" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and __fish_seen_subcommand_from logout" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and __fish_seen_subcommand_from logout" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and __fish_seen_subcommand_from status" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and __fish_seen_subcommand_from status" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and __fish_seen_subcommand_from status" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and __fish_seen_subcommand_from status" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and __fish_seen_subcommand_from help" -f -a "login" -d 'Authenticate via Device Authorization Flow (default) or browser OAuth'
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and __fish_seen_subcommand_from help" -f -a "logout" -d 'Clear the locally stored OAuth token'
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and __fish_seen_subcommand_from help" -f -a "status" -d 'Show authentication status'
complete -c longbridge -n "__fish_longbridge_using_subcommand auth; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand check" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand check" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand check" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand check" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand update" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand update" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand update" -l release-notes -d 'Show release notes instead of updating'
complete -c longbridge -n "__fish_longbridge_using_subcommand update" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand update" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand tui" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand tui" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand tui" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand tui" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand completion" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand completion" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand completion" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand completion" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand quote" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand quote" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand quote" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand quote" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand depth" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand depth" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand depth" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand depth" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand brokers" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand brokers" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand brokers" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand brokers" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand trades" -l count -d 'Number of trades to return (default: 20, max: 1000)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand trades" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand trades" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand trades" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand trades" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand intraday" -l session -d 'Trade session filter: `intraday` (default) | `all` (includes pre/post market)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand intraday" -l date -d 'Historical date in YYYYMMDD format (omit for today\'s live data)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand intraday" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand intraday" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand intraday" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand intraday" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and not __fish_seen_subcommand_from history help" -l period -d 'Candlestick period: 1m 5m 15m 30m 1h day week month year (default: day) Aliases: minute=1m, hour=1h, d/1d=day, w=week, m/1mo=month, y=year' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and not __fish_seen_subcommand_from history help" -l count -d 'Number of candles to return (default: 100)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and not __fish_seen_subcommand_from history help" -l adjust -d 'Price adjustment: `none` (default) | `forward`' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and not __fish_seen_subcommand_from history help" -l session -d 'Trade session filter: `intraday` (default) | `all` (includes pre/post market)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and not __fish_seen_subcommand_from history help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and not __fish_seen_subcommand_from history help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and not __fish_seen_subcommand_from history help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and not __fish_seen_subcommand_from history help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and not __fish_seen_subcommand_from history help" -a "history" -d 'Historical OHLCV candlestick data within a date range'
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and not __fish_seen_subcommand_from history help" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and __fish_seen_subcommand_from history" -l period -d 'Candlestick period: 1m 5m 15m 30m 1h day week month year (default: day)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and __fish_seen_subcommand_from history" -l start -d 'Start date (YYYY-MM-DD). Must be used together with --end' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and __fish_seen_subcommand_from history" -l end -d 'End date (YYYY-MM-DD). Must be used together with --start' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and __fish_seen_subcommand_from history" -l adjust -d 'Price adjustment: `none` (default) | `forward`' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and __fish_seen_subcommand_from history" -l session -d 'Trade session filter: intraday (default) | all (includes pre/post market)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and __fish_seen_subcommand_from history" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and __fish_seen_subcommand_from history" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and __fish_seen_subcommand_from history" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and __fish_seen_subcommand_from history" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and __fish_seen_subcommand_from help" -f -a "history" -d 'Historical OHLCV candlestick data within a date range'
complete -c longbridge -n "__fish_longbridge_using_subcommand kline; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand static" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand static" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand static" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand static" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand calc-index" -l fields -d 'Comma-separated fields to compute (default: pe,pb,`dps_rate`,`turnover_rate`,`total_market_value`) Unknown field names are silently ignored' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand calc-index" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand calc-index" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand calc-index" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand calc-index" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand capital" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand capital" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand capital" -l flow -d 'Show intraday capital flow time series instead of distribution snapshot'
complete -c longbridge -n "__fish_longbridge_using_subcommand capital" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand capital" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand market-temp" -l start -d 'Start date for history (YYYY-MM-DD). Defaults to today if omitted' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand market-temp" -l end -d 'End date for history (YYYY-MM-DD). Defaults to today if omitted' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand market-temp" -l granularity -d 'NOTE: currently unused — the SDK does not expose a granularity parameter' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand market-temp" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand market-temp" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand market-temp" -l history -d 'Return historical records instead of current value'
complete -c longbridge -n "__fish_longbridge_using_subcommand market-temp" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand market-temp" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and not __fish_seen_subcommand_from session days help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and not __fish_seen_subcommand_from session days help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and not __fish_seen_subcommand_from session days help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and not __fish_seen_subcommand_from session days help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and not __fish_seen_subcommand_from session days help" -f -a "session" -d 'Trading session schedule (open/close times) for all markets'
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and not __fish_seen_subcommand_from session days help" -f -a "days" -d 'Trading days and half-trading days for a market'
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and not __fish_seen_subcommand_from session days help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and __fish_seen_subcommand_from session" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and __fish_seen_subcommand_from session" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and __fish_seen_subcommand_from session" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and __fish_seen_subcommand_from session" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and __fish_seen_subcommand_from days" -l start -d 'Start date (YYYY-MM-DD), defaults to today' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and __fish_seen_subcommand_from days" -l end -d 'End date (YYYY-MM-DD), defaults to 30 days after start' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and __fish_seen_subcommand_from days" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and __fish_seen_subcommand_from days" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and __fish_seen_subcommand_from days" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and __fish_seen_subcommand_from days" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and __fish_seen_subcommand_from help" -f -a "session" -d 'Trading session schedule (open/close times) for all markets'
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and __fish_seen_subcommand_from help" -f -a "days" -d 'Trading days and half-trading days for a market'
complete -c longbridge -n "__fish_longbridge_using_subcommand trading; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand security-list" -l category -d 'NOTE: currently unused — the SDK only exposes the Overnight category' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand security-list" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand security-list" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand security-list" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand security-list" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand participants" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand participants" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand participants" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand participants" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand subscriptions" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand subscriptions" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand subscriptions" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand subscriptions" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and not __fish_seen_subcommand_from chain quote volume help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and not __fish_seen_subcommand_from chain quote volume help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and not __fish_seen_subcommand_from chain quote volume help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and not __fish_seen_subcommand_from chain quote volume help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and not __fish_seen_subcommand_from chain quote volume help" -f -a "chain" -d 'Option chain: expiry dates, or strike prices for a given expiry'
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and not __fish_seen_subcommand_from chain quote volume help" -f -a "quote" -d 'Real-time quotes for option contracts'
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and not __fish_seen_subcommand_from chain quote volume help" -f -a "volume" -d 'Real-time Call/Put volume snapshot; with `daily` subcommand shows historical data'
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and not __fish_seen_subcommand_from chain quote volume help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from chain" -l date -d 'Expiry date (YYYY-MM-DD). Omit to list all expiry dates' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from chain" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from chain" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from chain" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from chain" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from quote" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from quote" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from quote" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from quote" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from volume" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from volume" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from volume" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from volume" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from volume" -a "daily" -d 'Daily Call/Put volume and open interest history'
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from volume" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from help" -f -a "chain" -d 'Option chain: expiry dates, or strike prices for a given expiry'
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from help" -f -a "quote" -d 'Real-time quotes for option contracts'
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from help" -f -a "volume" -d 'Real-time Call/Put volume snapshot; with `daily` subcommand shows historical data'
complete -c longbridge -n "__fish_longbridge_using_subcommand option; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand warrant; and not __fish_seen_subcommand_from quote issuers help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand warrant; and not __fish_seen_subcommand_from quote issuers help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand warrant; and not __fish_seen_subcommand_from quote issuers help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand warrant; and not __fish_seen_subcommand_from quote issuers help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand warrant; and not __fish_seen_subcommand_from quote issuers help" -a "quote" -d 'Real-time quotes for warrant contracts'
complete -c longbridge -n "__fish_longbridge_using_subcommand warrant; and not __fish_seen_subcommand_from quote issuers help" -a "issuers" -d 'Warrant issuer list (HK market)'
complete -c longbridge -n "__fish_longbridge_using_subcommand warrant; and not __fish_seen_subcommand_from quote issuers help" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand warrant; and __fish_seen_subcommand_from quote" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand warrant; and __fish_seen_subcommand_from quote" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand warrant; and __fish_seen_subcommand_from quote" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand warrant; and __fish_seen_subcommand_from quote" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand warrant; and __fish_seen_subcommand_from issuers" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand warrant; and __fish_seen_subcommand_from issuers" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand warrant; and __fish_seen_subcommand_from issuers" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand warrant; and __fish_seen_subcommand_from issuers" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand warrant; and __fish_seen_subcommand_from help" -f -a "quote" -d 'Real-time quotes for warrant contracts'
complete -c longbridge -n "__fish_longbridge_using_subcommand warrant; and __fish_seen_subcommand_from help" -f -a "issuers" -d 'Warrant issuer list (HK market)'
complete -c longbridge -n "__fish_longbridge_using_subcommand warrant; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand financial-report" -l kind -d 'Statement type: IS (income), BS (balance sheet), CF (cash flow), ALL' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand financial-report" -l report -d 'Report period: af (annual), saf (semi-annual), q1 (Q1), 3q (3 quarters), qf (quarterly)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand financial-report" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand financial-report" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand financial-report" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand financial-report" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand institution-rating; and not __fish_seen_subcommand_from detail help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand institution-rating; and not __fish_seen_subcommand_from detail help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand institution-rating; and not __fish_seen_subcommand_from detail help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand institution-rating; and not __fish_seen_subcommand_from detail help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand institution-rating; and not __fish_seen_subcommand_from detail help" -a "detail" -d 'Historical institution rating and target price detail'
complete -c longbridge -n "__fish_longbridge_using_subcommand institution-rating; and not __fish_seen_subcommand_from detail help" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand institution-rating; and __fish_seen_subcommand_from detail" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand institution-rating; and __fish_seen_subcommand_from detail" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand institution-rating; and __fish_seen_subcommand_from detail" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand institution-rating; and __fish_seen_subcommand_from detail" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand institution-rating; and __fish_seen_subcommand_from help" -f -a "detail" -d 'Historical institution rating and target price detail'
complete -c longbridge -n "__fish_longbridge_using_subcommand institution-rating; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand dividend; and not __fish_seen_subcommand_from detail help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dividend; and not __fish_seen_subcommand_from detail help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dividend; and not __fish_seen_subcommand_from detail help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand dividend; and not __fish_seen_subcommand_from detail help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand dividend; and not __fish_seen_subcommand_from detail help" -a "detail" -d 'Dividend distribution scheme details'
complete -c longbridge -n "__fish_longbridge_using_subcommand dividend; and not __fish_seen_subcommand_from detail help" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand dividend; and __fish_seen_subcommand_from detail" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dividend; and __fish_seen_subcommand_from detail" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dividend; and __fish_seen_subcommand_from detail" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand dividend; and __fish_seen_subcommand_from detail" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand dividend; and __fish_seen_subcommand_from help" -f -a "detail" -d 'Dividend distribution scheme details'
complete -c longbridge -n "__fish_longbridge_using_subcommand dividend; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand forecast-eps" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand forecast-eps" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand forecast-eps" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand forecast-eps" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand consensus" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand consensus" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand consensus" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand consensus" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand finance-calendar" -l symbol -d 'Filter by symbol, repeatable (max 10)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand finance-calendar" -l market -d 'Filter by market, repeatable (HK, US, CN, SG, JP, UK, DE, AU)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand finance-calendar" -l start -d 'Start date (YYYY-MM-DD), defaults to today' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand finance-calendar" -l end -d 'End date (YYYY-MM-DD), defaults to no limit' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand finance-calendar" -l count -d 'Max events returned (default: 100)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand finance-calendar" -l star -d 'Macro data importance filter, repeatable (1, 2, 3); only effective for macrodata type' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand finance-calendar" -l next -d 'Pagination direction: later (default) or earlier' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand finance-calendar" -l offset -d 'Pagination offset (default: 0)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand finance-calendar" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand finance-calendar" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand finance-calendar" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand finance-calendar" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand valuation" -l indicator -d 'Valuation indicator for history mode: `pe` | `pb` | `ps` | `dvd_yld`' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand valuation" -l range -d 'Historical range in years (history mode, default: 1): 1 | 3 | 5 | 10' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand valuation" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand valuation" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand valuation" -l history -d 'Show historical valuation time series instead of current snapshot'
complete -c longbridge -n "__fish_longbridge_using_subcommand valuation" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand valuation" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand news; and not __fish_seen_subcommand_from detail help" -l count -d 'Maximum number of articles to show (default: 20)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand news; and not __fish_seen_subcommand_from detail help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand news; and not __fish_seen_subcommand_from detail help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand news; and not __fish_seen_subcommand_from detail help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand news; and not __fish_seen_subcommand_from detail help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand news; and not __fish_seen_subcommand_from detail help" -a "detail" -d 'Full Markdown content of a news article'
complete -c longbridge -n "__fish_longbridge_using_subcommand news; and not __fish_seen_subcommand_from detail help" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand news; and __fish_seen_subcommand_from detail" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand news; and __fish_seen_subcommand_from detail" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand news; and __fish_seen_subcommand_from detail" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand news; and __fish_seen_subcommand_from detail" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand news; and __fish_seen_subcommand_from help" -f -a "detail" -d 'Full Markdown content of a news article'
complete -c longbridge -n "__fish_longbridge_using_subcommand news; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand filing; and not __fish_seen_subcommand_from detail help" -l count -d 'Maximum number of filings to show (default: 20)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand filing; and not __fish_seen_subcommand_from detail help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand filing; and not __fish_seen_subcommand_from detail help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand filing; and not __fish_seen_subcommand_from detail help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand filing; and not __fish_seen_subcommand_from detail help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand filing; and not __fish_seen_subcommand_from detail help" -a "detail" -d 'Full Markdown content of a regulatory filing (HTML and TXT only)'
complete -c longbridge -n "__fish_longbridge_using_subcommand filing; and not __fish_seen_subcommand_from detail help" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand filing; and __fish_seen_subcommand_from detail" -l file-index -d 'Index of the file to fetch (0-based, default 0)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand filing; and __fish_seen_subcommand_from detail" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand filing; and __fish_seen_subcommand_from detail" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand filing; and __fish_seen_subcommand_from detail" -l list-files -d 'List all available file URLs without fetching content'
complete -c longbridge -n "__fish_longbridge_using_subcommand filing; and __fish_seen_subcommand_from detail" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand filing; and __fish_seen_subcommand_from detail" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand filing; and __fish_seen_subcommand_from help" -f -a "detail" -d 'Full Markdown content of a regulatory filing (HTML and TXT only)'
complete -c longbridge -n "__fish_longbridge_using_subcommand filing; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and not __fish_seen_subcommand_from detail mine create replies create-reply help" -l count -d 'Maximum number of topics to show (default: 20)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and not __fish_seen_subcommand_from detail mine create replies create-reply help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and not __fish_seen_subcommand_from detail mine create replies create-reply help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and not __fish_seen_subcommand_from detail mine create replies create-reply help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and not __fish_seen_subcommand_from detail mine create replies create-reply help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and not __fish_seen_subcommand_from detail mine create replies create-reply help" -a "detail" -d 'Get full details of a community topic by its ID'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and not __fish_seen_subcommand_from detail mine create replies create-reply help" -a "mine" -d 'Topics created by the authenticated user'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and not __fish_seen_subcommand_from detail mine create replies create-reply help" -a "create" -d 'Publish a new community discussion topic'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and not __fish_seen_subcommand_from detail mine create replies create-reply help" -a "replies" -d 'List replies for a community topic (paginated)'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and not __fish_seen_subcommand_from detail mine create replies create-reply help" -a "create-reply" -d 'Post a reply to a community topic'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and not __fish_seen_subcommand_from detail mine create replies create-reply help" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from detail" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from detail" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from detail" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from detail" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from mine" -l page -d 'Page number (default: 1)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from mine" -l size -d 'Records per page, 1-500 (default: 50)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from mine" -l type -d 'Filter by content type: article | post (omit for all)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from mine" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from mine" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from mine" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from mine" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from create" -l title -d 'Topic title. Required for --type article; optional for --type post' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from create" -l body -d 'Topic body. post: plain text. article: Markdown, title required' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from create" -l type -d 'Content type: post (default) | article' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from create" -l tickers -d 'Extra tickers to associate, comma-separated, e.g. 700.HK,TSLA.US (max 10)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from create" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from create" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from create" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from replies" -l page -d 'Page number, 1-based (default: 1)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from replies" -l size -d 'Records per page, 1-50 (default: 20)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from replies" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from replies" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from replies" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from replies" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from create-reply" -l body -d 'Reply body - plain text only' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from create-reply" -l reply-to -d 'Nest under this reply ID (get IDs from topic-replies). Omit for a top-level reply' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from create-reply" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from create-reply" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from create-reply" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from create-reply" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from help" -f -a "detail" -d 'Get full details of a community topic by its ID'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from help" -f -a "mine" -d 'Topics created by the authenticated user'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from help" -f -a "create" -d 'Publish a new community discussion topic'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from help" -f -a "replies" -d 'List replies for a community topic (paginated)'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from help" -f -a "create-reply" -d 'Post a reply to a community topic'
complete -c longbridge -n "__fish_longbridge_using_subcommand topic; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and not __fish_seen_subcommand_from show create delete update pin help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and not __fish_seen_subcommand_from show create delete update pin help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and not __fish_seen_subcommand_from show create delete update pin help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and not __fish_seen_subcommand_from show create delete update pin help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and not __fish_seen_subcommand_from show create delete update pin help" -f -a "show" -d 'Show securities in a specific watchlist group (by ID or name)'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and not __fish_seen_subcommand_from show create delete update pin help" -f -a "create" -d 'Create a new watchlist group'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and not __fish_seen_subcommand_from show create delete update pin help" -f -a "delete" -d 'Delete a watchlist group (prompts for confirmation)'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and not __fish_seen_subcommand_from show create delete update pin help" -f -a "update" -d 'Add/remove securities in a group, or rename it'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and not __fish_seen_subcommand_from show create delete update pin help" -f -a "pin" -d 'Pin or unpin securities so they appear at the top of a watchlist group'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and not __fish_seen_subcommand_from show create delete update pin help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from show" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from show" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from show" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from show" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from create" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from create" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from create" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from delete" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from delete" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from delete" -l purge -d 'Also remove all securities inside the group'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from delete" -s y -l yes -d 'Skip confirmation prompt (useful for scripting and AI agents)'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from delete" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from update" -l name -d 'New display name (optional)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from update" -l add -d 'Symbols to add (repeatable: --add TSLA.US --add AAPL.US)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from update" -l remove -d 'Symbols to remove (repeatable: --remove 700.HK)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from update" -l mode -d 'Update mode: add (default) | remove | replace (overwrite with --add list)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from update" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from update" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from update" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from pin" -l remove -d 'Symbols to unpin (repeatable: --remove 700.HK)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from pin" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from pin" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from pin" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from pin" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from help" -f -a "show" -d 'Show securities in a specific watchlist group (by ID or name)'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a new watchlist group'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a watchlist group (prompts for confirmation)'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from help" -f -a "update" -d 'Add/remove securities in a group, or rename it'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from help" -f -a "pin" -d 'Pin or unpin securities so they appear at the top of a watchlist group'
complete -c longbridge -n "__fish_longbridge_using_subcommand watchlist; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and not __fish_seen_subcommand_from list export help" -l type -d 'Statement type: daily (default) | monthly' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and not __fish_seen_subcommand_from list export help" -l start-date -d 'Start date (YYYY-MM-DD, e.g. 2026-01-21). Defaults to 30 days ago' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and not __fish_seen_subcommand_from list export help" -l limit -d 'Number of records to return. Defaults to 30 for daily, 12 for monthly' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and not __fish_seen_subcommand_from list export help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and not __fish_seen_subcommand_from list export help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and not __fish_seen_subcommand_from list export help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and not __fish_seen_subcommand_from list export help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and not __fish_seen_subcommand_from list export help" -f -a "list" -d 'List available statements for an account'
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and not __fish_seen_subcommand_from list export help" -f -a "export" -d 'Export statement sections as CSV files or markdown'
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and not __fish_seen_subcommand_from list export help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from list" -l type -d 'Statement type: daily (default) | monthly' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from list" -l start-date -d 'Start date (YYYY-MM-DD, e.g. 2026-01-21). Defaults to 30 days ago' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from list" -l limit -d 'Number of records to return. Defaults to 30 for daily, 12 for monthly' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from list" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from list" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from list" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from export" -l file-key -d 'File key from `longbridge statement list`' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from export" -l section -d 'Sections to export (can specify multiple)' -r -f -a "asset\t''
account_balances\t''
equity_holdings\t''
account_balance_changes\t''
stock_trades\t''
equity_holding_changes\t''
account_balance_locks\t''
equity_holding_locks\t''
option_trades\t''
fund_trades\t''
ipo_trades\t''
virtual_trades\t''
interests\t''
lending_fees\t''
custodian_fees\t''
corps\t''
bond_equity_holdings\t''
otc_trades\t''
outstandings\t''
financing_transactions\t''
interest_deposits\t''
maintenance_fees\t''
cash_pluses\t''
gst_details\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from export" -l export-format -d 'Export format: csv | md. Defaults to `md` when `-o` is omitted, `csv` when `-o` is provided' -r -f -a "csv\t''
md\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from export" -s o -l output -d 'Output directory or file path. When multiple sections are specified, this is treated as a directory and each section is saved as a separate file inside it. Omit to print to stdout' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from export" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from export" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from export" -l all -d 'Export all sections (empty sections are skipped). Defaults to true when --section is not specified'
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from export" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from export" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from help" -f -a "list" -d 'List available statements for an account'
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from help" -f -a "export" -d 'Export statement sections as CSV files or markdown'
complete -c longbridge -n "__fish_longbridge_using_subcommand statement; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and not __fish_seen_subcommand_from detail executions buy sell cancel replace help" -l start -d 'Filter start date (YYYY-MM-DD)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and not __fish_seen_subcommand_from detail executions buy sell cancel replace help" -l end -d 'Filter end date (YYYY-MM-DD)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and not __fish_seen_subcommand_from detail executions buy sell cancel replace help" -l symbol -d 'Filter by symbol (e.g. TSLA.US)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and not __fish_seen_subcommand_from detail executions buy sell cancel replace help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and not __fish_seen_subcommand_from detail executions buy sell cancel replace help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and not __fish_seen_subcommand_from detail executions buy sell cancel replace help" -l history -d 'Return historical orders instead of today\'s (list mode only)'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and not __fish_seen_subcommand_from detail executions buy sell cancel replace help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and not __fish_seen_subcommand_from detail executions buy sell cancel replace help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and not __fish_seen_subcommand_from detail executions buy sell cancel replace help" -f -a "detail" -d 'Full detail for a single order including charges and history'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and not __fish_seen_subcommand_from detail executions buy sell cancel replace help" -f -a "executions" -d 'Today\'s trade executions (fills), or historical with --history'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and not __fish_seen_subcommand_from detail executions buy sell cancel replace help" -f -a "buy" -d 'Submit a buy order (prompts for confirmation)'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and not __fish_seen_subcommand_from detail executions buy sell cancel replace help" -f -a "sell" -d 'Submit a sell order (prompts for confirmation)'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and not __fish_seen_subcommand_from detail executions buy sell cancel replace help" -f -a "cancel" -d 'Cancel a pending order (prompts for confirmation)'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and not __fish_seen_subcommand_from detail executions buy sell cancel replace help" -f -a "replace" -d 'Modify quantity or price of a pending order (prompts for confirmation)'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and not __fish_seen_subcommand_from detail executions buy sell cancel replace help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from detail" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from detail" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from detail" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from detail" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from executions" -l start -d 'Filter start date (YYYY-MM-DD)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from executions" -l end -d 'Filter end date (YYYY-MM-DD)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from executions" -l symbol -d 'Filter by symbol' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from executions" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from executions" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from executions" -l history -d 'Return historical executions instead of today\'s'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from executions" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from executions" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from buy" -l price -d 'Limit price as a decimal string, e.g. 250.00 (required for LO/ELO/ALO/LIT; omit for MO/MIT)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from buy" -l trigger-price -d 'Trigger price for conditional orders (required for MIT/LIT)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from buy" -l trailing-amount -d 'Trailing amount for TSLPAMT/TSMAMT orders' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from buy" -l trailing-percent -d 'Trailing percent for TSLPPCT/TSMPCT orders' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from buy" -l limit-offset -d 'Limit offset for TSLPAMT/TSLPPCT orders (spread between trigger and limit price)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from buy" -l expire-date -d 'Expiry date for GTD orders in YYYY-MM-DD format (required when --tif gtd)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from buy" -l outside-rth -d 'Outside regular trading hours: `RTH_ONLY` | `ANY_TIME` | `OVERNIGHT` (US market only)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from buy" -l remark -d 'Order remark (max 255 characters)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from buy" -l order-type -d 'Order type: LO ELO MO AO ALO ODD SLO LIT MIT TSLPAMT TSLPPCT (case-insensitive, default: LO)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from buy" -l tif -d 'Time in force: day | gtc (`GoodTilCanceled`) | gtd (`GoodTilDate`) (case-insensitive)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from buy" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from buy" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from buy" -s y -l yes -d 'Skip confirmation prompt (useful for scripting and AI agents)'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from buy" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from buy" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from sell" -l price -d 'Limit price as a decimal string, e.g. 260.00 (required for LO/ELO/ALO/LIT; omit for MO/MIT)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from sell" -l trigger-price -d 'Trigger price for conditional orders (required for MIT/LIT)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from sell" -l trailing-amount -d 'Trailing amount for TSLPAMT/TSMAMT orders' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from sell" -l trailing-percent -d 'Trailing percent for TSLPPCT/TSMPCT orders' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from sell" -l limit-offset -d 'Limit offset for TSLPAMT/TSLPPCT orders (spread between trigger and limit price)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from sell" -l expire-date -d 'Expiry date for GTD orders in YYYY-MM-DD format (required when --tif gtd)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from sell" -l outside-rth -d 'Outside regular trading hours: `RTH_ONLY` | `ANY_TIME` | `OVERNIGHT` (US market only)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from sell" -l remark -d 'Order remark (max 255 characters)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from sell" -l order-type -d 'Order type: LO ELO MO AO ALO ODD SLO LIT MIT TSLPAMT TSLPPCT (case-insensitive, default: LO)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from sell" -l tif -d 'Time in force: day | gtc (`GoodTilCanceled`) | gtd (`GoodTilDate`) (case-insensitive)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from sell" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from sell" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from sell" -s y -l yes -d 'Skip confirmation prompt (useful for scripting and AI agents)'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from sell" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from sell" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from cancel" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from cancel" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from cancel" -s y -l yes -d 'Skip confirmation prompt (useful for scripting and AI agents)'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from cancel" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from cancel" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from replace" -l qty -d 'New quantity (REQUIRED — integer number of shares/units)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from replace" -l price -d 'New limit price as a decimal string, e.g. 255.00 (optional)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from replace" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from replace" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from replace" -s y -l yes -d 'Skip confirmation prompt (useful for scripting and AI agents)'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from replace" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from replace" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from help" -f -a "detail" -d 'Full detail for a single order including charges and history'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from help" -f -a "executions" -d 'Today\'s trade executions (fills), or historical with --history'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from help" -f -a "buy" -d 'Submit a buy order (prompts for confirmation)'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from help" -f -a "sell" -d 'Submit a sell order (prompts for confirmation)'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from help" -f -a "cancel" -d 'Cancel a pending order (prompts for confirmation)'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from help" -f -a "replace" -d 'Modify quantity or price of a pending order (prompts for confirmation)'
complete -c longbridge -n "__fish_longbridge_using_subcommand order; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand assets" -l currency -d 'Filter by currency (e.g. USD HKD CNY SGD)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand assets" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand assets" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand assets" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand assets" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand cash-flow" -l start -d 'Start date (YYYY-MM-DD), defaults to 30 days ago' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand cash-flow" -l end -d 'End date (YYYY-MM-DD), defaults to today' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand cash-flow" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand cash-flow" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand cash-flow" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand cash-flow" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand portfolio" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand portfolio" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand portfolio" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand portfolio" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand positions" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand positions" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand positions" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand positions" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand fund-positions" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand fund-positions" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand fund-positions" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand fund-positions" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand margin-ratio" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand margin-ratio" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand margin-ratio" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand margin-ratio" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand max-qty" -l side -d 'Order side: buy | sell  (case-insensitive, REQUIRED)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand max-qty" -l price -d 'Limit price as a decimal string, e.g. 250.00 (required for LO orders)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand max-qty" -l order-type -d 'Order type: LO | MO | ELO | ALO  (case-insensitive, default: LO)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand max-qty" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand max-qty" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand max-qty" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand max-qty" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand exchange-rate" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand exchange-rate" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand exchange-rate" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand exchange-rate" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand shareholder" -l range -d 'Filter by change direction: all | inc (increase) | dec (decrease)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand shareholder" -l sort -d 'Sort field: chg (change) | owned (holdings) | time (report date)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand shareholder" -l order -d 'Sort order: desc | asc' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand shareholder" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand shareholder" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand shareholder" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand shareholder" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand company" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand company" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand company" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand company" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand executive" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand executive" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand executive" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand executive" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand industry-valuation; and not __fish_seen_subcommand_from dist help" -l currency -d 'Currency: USD | HKD | CNY | SGD' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand industry-valuation; and not __fish_seen_subcommand_from dist help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand industry-valuation; and not __fish_seen_subcommand_from dist help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand industry-valuation; and not __fish_seen_subcommand_from dist help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand industry-valuation; and not __fish_seen_subcommand_from dist help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand industry-valuation; and not __fish_seen_subcommand_from dist help" -a "dist" -d 'Industry valuation distribution (percentile ranking)'
complete -c longbridge -n "__fish_longbridge_using_subcommand industry-valuation; and not __fish_seen_subcommand_from dist help" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand industry-valuation; and __fish_seen_subcommand_from dist" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand industry-valuation; and __fish_seen_subcommand_from dist" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand industry-valuation; and __fish_seen_subcommand_from dist" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand industry-valuation; and __fish_seen_subcommand_from dist" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand industry-valuation; and __fish_seen_subcommand_from help" -f -a "dist" -d 'Industry valuation distribution (percentile ranking)'
complete -c longbridge -n "__fish_longbridge_using_subcommand industry-valuation; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand operating" -l report -d 'Report kind filter: af | saf | q1 | q3 (comma-separated for multiple)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand operating" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand operating" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand operating" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand operating" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand corp-action" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand corp-action" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand corp-action" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand corp-action" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand invest-relation" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand invest-relation" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand invest-relation" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand invest-relation" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand constituent" -l limit -d 'Number of results to return' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand constituent" -l sort -d 'Sort indicator: change, price, turnover, inflow, turnover-rate, market-cap' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand constituent" -l order -d 'Sort order: desc | asc' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand constituent" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand constituent" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand constituent" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand constituent" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand market-status" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand market-status" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand market-status" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand market-status" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and not __fish_seen_subcommand_from detail daily help" -l period -d 'Period for top buy/sell: `rct_1`, `rct_5`, `rct_20`, `rct_60`' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and not __fish_seen_subcommand_from detail daily help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and not __fish_seen_subcommand_from detail daily help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and not __fish_seen_subcommand_from detail daily help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and not __fish_seen_subcommand_from detail daily help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and not __fish_seen_subcommand_from detail daily help" -a "detail" -d 'Full broker holding detail list'
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and not __fish_seen_subcommand_from detail daily help" -a "daily" -d 'Daily holding history for a specific broker'
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and not __fish_seen_subcommand_from detail daily help" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and __fish_seen_subcommand_from detail" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and __fish_seen_subcommand_from detail" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and __fish_seen_subcommand_from detail" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and __fish_seen_subcommand_from detail" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and __fish_seen_subcommand_from daily" -l broker -d 'Broker participant number from the `parti_no` column (e.g. B01224)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and __fish_seen_subcommand_from daily" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and __fish_seen_subcommand_from daily" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and __fish_seen_subcommand_from daily" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and __fish_seen_subcommand_from daily" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and __fish_seen_subcommand_from help" -f -a "detail" -d 'Full broker holding detail list'
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and __fish_seen_subcommand_from help" -f -a "daily" -d 'Daily holding history for a specific broker'
complete -c longbridge -n "__fish_longbridge_using_subcommand broker-holding; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand ah-premium; and not __fish_seen_subcommand_from intraday help" -l kline-type -d 'K-line type: 1m | 5m | 15m | 30m | 60m | day | week | month | year' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand ah-premium; and not __fish_seen_subcommand_from intraday help" -l count -d 'Number of K-lines to return' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand ah-premium; and not __fish_seen_subcommand_from intraday help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand ah-premium; and not __fish_seen_subcommand_from intraday help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand ah-premium; and not __fish_seen_subcommand_from intraday help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand ah-premium; and not __fish_seen_subcommand_from intraday help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand ah-premium; and not __fish_seen_subcommand_from intraday help" -a "intraday" -d 'AH premium intraday timeshare data'
complete -c longbridge -n "__fish_longbridge_using_subcommand ah-premium; and not __fish_seen_subcommand_from intraday help" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand ah-premium; and __fish_seen_subcommand_from intraday" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand ah-premium; and __fish_seen_subcommand_from intraday" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand ah-premium; and __fish_seen_subcommand_from intraday" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand ah-premium; and __fish_seen_subcommand_from intraday" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand ah-premium; and __fish_seen_subcommand_from help" -f -a "intraday" -d 'AH premium intraday timeshare data'
complete -c longbridge -n "__fish_longbridge_using_subcommand ah-premium; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand trade-stats" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand trade-stats" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand trade-stats" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand trade-stats" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand anomaly" -l market -d 'Market: HK | US | CN | SG' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand anomaly" -l symbol -d 'Filter to a specific symbol' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand anomaly" -l count -d 'Number of results (max 100)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand anomaly" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand anomaly" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand anomaly" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand anomaly" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and not __fish_seen_subcommand_from add delete enable disable help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and not __fish_seen_subcommand_from add delete enable disable help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and not __fish_seen_subcommand_from add delete enable disable help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and not __fish_seen_subcommand_from add delete enable disable help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and not __fish_seen_subcommand_from add delete enable disable help" -a "add" -d 'Add a price alert'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and not __fish_seen_subcommand_from add delete enable disable help" -a "delete" -d 'Delete a price alert by id (from `longbridge alert` list)'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and not __fish_seen_subcommand_from add delete enable disable help" -a "enable" -d 'Enable a price alert by id'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and not __fish_seen_subcommand_from add delete enable disable help" -a "disable" -d 'Disable a price alert by id'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and not __fish_seen_subcommand_from add delete enable disable help" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from add" -l price -d 'Target price or percentage value' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from add" -l direction -d 'Direction: rise | fall' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from add" -l alert-type -d 'Alert type: price | percent' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from add" -l frequency -d 'Frequency: once | daily | every' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from add" -l note -d 'Optional note' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from add" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from add" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from add" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from add" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from delete" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from delete" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from delete" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from enable" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from enable" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from enable" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from enable" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from disable" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from disable" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from disable" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from disable" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from help" -f -a "add" -d 'Add a price alert'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a price alert by id (from `longbridge alert` list)'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from help" -f -a "enable" -d 'Enable a price alert by id'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from help" -f -a "disable" -d 'Disable a price alert by id'
complete -c longbridge -n "__fish_longbridge_using_subcommand alert; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and not __fish_seen_subcommand_from detail by-market help" -l start -d 'Start date (YYYY-MM-DD)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and not __fish_seen_subcommand_from detail by-market help" -l end -d 'End date (YYYY-MM-DD)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and not __fish_seen_subcommand_from detail by-market help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and not __fish_seen_subcommand_from detail by-market help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and not __fish_seen_subcommand_from detail by-market help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and not __fish_seen_subcommand_from detail by-market help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and not __fish_seen_subcommand_from detail by-market help" -f -a "detail" -d 'Individual stock P&L detail with transaction flows'
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and not __fish_seen_subcommand_from detail by-market help" -f -a "by-market" -d 'Stock P&L by market with pagination'
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and not __fish_seen_subcommand_from detail by-market help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from detail" -l start -d 'Start date (YYYY-MM-DD)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from detail" -l end -d 'End date (YYYY-MM-DD)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from detail" -l currency -d 'Currency filter (e.g. HKD, USD, CNH)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from detail" -l page -d 'Flows page number (default: 1)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from detail" -l size -d 'Flows page size (default: 30)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from detail" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from detail" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from detail" -l derivative -d 'Show derivative flows instead of underlying'
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from detail" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from detail" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from by-market" -l start -d 'Start date (YYYY-MM-DD)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from by-market" -l end -d 'End date (YYYY-MM-DD)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from by-market" -l currency -d 'Currency filter (e.g. HKD, USD, CNH)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from by-market" -l page -d 'Page number (default: 1)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from by-market" -l size -d 'Page size (default: 50)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from by-market" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from by-market" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from by-market" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from by-market" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from help" -f -a "detail" -d 'Individual stock P&L detail with transaction flows'
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from help" -f -a "by-market" -d 'Stock P&L by market with pagination'
complete -c longbridge -n "__fish_longbridge_using_subcommand profit-analysis; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand fund-holder" -l count -d 'Number of results to return (-1 for all)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand fund-holder" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand fund-holder" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand fund-holder" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand fund-holder" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand insider-trades" -l count -d 'Number of Form 4 filings to fetch (default: 20)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand insider-trades" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand insider-trades" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand insider-trades" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand insider-trades" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand investors; and not __fish_seen_subcommand_from changes help" -l top -d 'Number of top holdings to display, sorted by value (default: 50)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand investors; and not __fish_seen_subcommand_from changes help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand investors; and not __fish_seen_subcommand_from changes help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand investors; and not __fish_seen_subcommand_from changes help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand investors; and not __fish_seen_subcommand_from changes help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand investors; and not __fish_seen_subcommand_from changes help" -a "changes" -d 'Show position changes between two 13F filings (NEW/ADDED/REDUCED/EXITED)'
complete -c longbridge -n "__fish_longbridge_using_subcommand investors; and not __fish_seen_subcommand_from changes help" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand investors; and __fish_seen_subcommand_from changes" -l top -d 'Number of changes to display (default: 50)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand investors; and __fish_seen_subcommand_from changes" -l from -d 'Base period to compare against (report date, e.g. 2024-12-31). Defaults to the filing immediately before the latest one' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand investors; and __fish_seen_subcommand_from changes" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand investors; and __fish_seen_subcommand_from changes" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand investors; and __fish_seen_subcommand_from changes" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand investors; and __fish_seen_subcommand_from changes" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand investors; and __fish_seen_subcommand_from help" -f -a "changes" -d 'Show position changes between two 13F filings (NEW/ADDED/REDUCED/EXITED)'
complete -c longbridge -n "__fish_longbridge_using_subcommand investors; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -l status -d 'Filter plans by status: Active | Suspended | Finished' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -l symbol -d 'Filter plans by symbol (e.g. AAPL.US)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -l page -d 'Page number (default: 1)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -l limit -d 'Records per page (default: 20)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -f -a "create" -d 'Create a new recurring investment plan'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -f -a "update" -d 'Update an existing recurring investment plan'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -f -a "pause" -d 'Pause a recurring investment plan'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -f -a "resume" -d 'Resume a paused recurring investment plan'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -f -a "stop" -d 'Permanently stop a recurring investment plan'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -f -a "history" -d 'Show trade history for a recurring investment plan'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -f -a "stats" -d 'Show recurring investment statistics summary'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -f -a "calc-date" -d 'Calculate the next trade date for given plan parameters'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -f -a "check" -d 'Check whether symbols support recurring investment'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -f -a "set-reminder" -d 'Set the pre-trade reminder hours'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and not __fish_seen_subcommand_from create update pause resume stop history stats calc-date check set-reminder help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from create" -l amount -d 'Amount per investment period (as a decimal string, e.g. 500)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from create" -l frequency -d 'Investment frequency: daily | weekly | fortnightly (every two weeks) | monthly' -r -f -a "daily\t''
weekly\t''
fortnightly\t''
monthly\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from create" -l day-of-week -d 'Day of week for weekly/fortnightly: mon tue wed thu fri' -r -f -a "mon\t''
tue\t''
wed\t''
thu\t''
fri\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from create" -l day-of-month -d 'Day of month for monthly plans (1–28)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from create" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from create" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from create" -l allow-margin -d 'Allow margin financing for the investment amount (default: false)'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from create" -l agree-terms -d 'Agree to the Terms and Conditions without interactive prompt'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from create" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from update" -l amount -d 'New amount per investment period' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from update" -l frequency -d 'New investment frequency: daily | weekly | fortnightly (every two weeks) | monthly' -r -f -a "daily\t''
weekly\t''
fortnightly\t''
monthly\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from update" -l day-of-week -d 'Day of week for weekly/fortnightly: mon tue wed thu fri' -r -f -a "mon\t''
tue\t''
wed\t''
thu\t''
fri\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from update" -l day-of-month -d 'Day of month for monthly plans (1–28)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from update" -l allow-margin -d 'Allow margin financing' -r -f -a "true\t''
false\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from update" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from update" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from update" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from update" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from pause" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from pause" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from pause" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from pause" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from resume" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from resume" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from resume" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from resume" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from stop" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from stop" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from stop" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from stop" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from history" -l page -d 'Page number (default: 1)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from history" -l limit -d 'Records per page (default: 20)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from history" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from history" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from history" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from history" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from stats" -l symbol -d 'Filter statistics by symbol' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from stats" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from stats" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from stats" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from stats" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from calc-date" -l frequency -d 'Investment frequency: daily | weekly | fortnightly | monthly' -r -f -a "daily\t''
weekly\t''
fortnightly\t''
monthly\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from calc-date" -l day-of-week -d 'Day of week for weekly/fortnightly: mon tue wed thu fri' -r -f -a "mon\t''
tue\t''
wed\t''
thu\t''
fri\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from calc-date" -l day-of-month -d 'Day of month for monthly plans (1–28)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from calc-date" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from calc-date" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from calc-date" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from calc-date" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from check" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from check" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from check" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from check" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from set-reminder" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from set-reminder" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from set-reminder" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from set-reminder" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a new recurring investment plan'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from help" -f -a "update" -d 'Update an existing recurring investment plan'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from help" -f -a "pause" -d 'Pause a recurring investment plan'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from help" -f -a "resume" -d 'Resume a paused recurring investment plan'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from help" -f -a "stop" -d 'Permanently stop a recurring investment plan'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from help" -f -a "history" -d 'Show trade history for a recurring investment plan'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from help" -f -a "stats" -d 'Show recurring investment statistics summary'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from help" -f -a "calc-date" -d 'Calculate the next trade date for given plan parameters'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from help" -f -a "check" -d 'Check whether symbols support recurring investment'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from help" -f -a "set-reminder" -d 'Set the pre-trade reminder hours'
complete -c longbridge -n "__fish_longbridge_using_subcommand dca; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand short-positions" -l count -d 'Number of records to return (1–100, default: 20)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand short-positions" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand short-positions" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand short-positions" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand short-positions" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and not __fish_seen_subcommand_from detail create delete add remove sort popular help" -l count -d 'Number of sharelists to return (default: 20)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and not __fish_seen_subcommand_from detail create delete add remove sort popular help" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and not __fish_seen_subcommand_from detail create delete add remove sort popular help" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and not __fish_seen_subcommand_from detail create delete add remove sort popular help" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and not __fish_seen_subcommand_from detail create delete add remove sort popular help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and not __fish_seen_subcommand_from detail create delete add remove sort popular help" -f -a "detail" -d 'Show full details for a sharelist including its constituent stocks'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and not __fish_seen_subcommand_from detail create delete add remove sort popular help" -f -a "create" -d 'Create a new sharelist'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and not __fish_seen_subcommand_from detail create delete add remove sort popular help" -f -a "delete" -d 'Delete a sharelist'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and not __fish_seen_subcommand_from detail create delete add remove sort popular help" -f -a "add" -d 'Add stocks to a sharelist'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and not __fish_seen_subcommand_from detail create delete add remove sort popular help" -f -a "remove" -d 'Remove stocks from a sharelist'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and not __fish_seen_subcommand_from detail create delete add remove sort popular help" -f -a "sort" -d 'Reorder the stocks in a sharelist'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and not __fish_seen_subcommand_from detail create delete add remove sort popular help" -f -a "popular" -d 'Get popular (trending) sharelists'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and not __fish_seen_subcommand_from detail create delete add remove sort popular help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from detail" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from detail" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from detail" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from detail" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from create" -l name -d 'Sharelist name' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from create" -l description -d 'Sharelist description' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from create" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from create" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from create" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from delete" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from delete" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from delete" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from add" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from add" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from add" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from add" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from remove" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from remove" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from remove" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from remove" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from sort" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from sort" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from sort" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from sort" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from popular" -l count -d 'Number of results to return (default: 20)' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from popular" -l format -d 'Output format: \'pretty\' for human-readable, \'json\' for AI agents and scripting' -r -f -a "table\t''
json\t''"
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from popular" -l lang -d 'Language for content fetched from longbridge.com: zh-CN or en. Defaults to system LANG env var, then en' -r
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from popular" -s v -l verbose -d 'Print verbose request info (host, elapsed) to stderr, prefixed with `*` like curl -v'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from popular" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from help" -f -a "detail" -d 'Show full details for a sharelist including its constituent stocks'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a new sharelist'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a sharelist'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from help" -f -a "add" -d 'Add stocks to a sharelist'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from help" -f -a "remove" -d 'Remove stocks from a sharelist'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from help" -f -a "sort" -d 'Reorder the stocks in a sharelist'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from help" -f -a "popular" -d 'Get popular (trending) sharelists'
complete -c longbridge -n "__fish_longbridge_using_subcommand sharelist; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "auth" -d 'Authenticate or clear credentials'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "check" -d 'Check token validity, and API connectivity'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "update" -d 'Update longbridge to the latest version'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "tui" -d 'Launch the interactive full-screen TUI (terminal UI)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "completion" -d 'Generate shell completion script'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "quote" -d 'Real-time quotes for one or more symbols'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "depth" -d 'Level 2 order book depth (bid/ask ladder)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "brokers" -d 'Broker queue at each price level (HK market)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "trades" -d 'Recent tick-by-tick trades'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "intraday" -d 'Intraday minute-by-minute price and volume lines for today (or a historical date)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "kline" -d 'OHLCV candlestick (K-line) data, or historical date-range candlesticks'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "static" -d 'Static reference info for one or more symbols'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "calc-index" -d 'Calculated financial indexes (PE, PB, DPS rate, turnover rate, etc.)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "capital" -d 'Intraday capital distribution snapshot, or flow time series with --flow'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "market-temp" -d 'Market sentiment temperature index (0–100, higher = more bullish)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "trading" -d 'Trading session schedule and trading calendar'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "security-list" -d 'List of US overnight-eligible securities'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "participants" -d 'Market maker (participant) broker IDs and names'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "subscriptions" -d 'Active real-time WebSocket subscriptions for this session'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "option" -d 'Option quotes, option chain, and option volume statistics'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "warrant" -d 'Warrant quotes, warrant list, and issuer list'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "financial-report" -d 'Financial statements (income, balance sheet, cash flow) for a symbol'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "institution-rating" -d 'Institution rating overview and target price summary'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "dividend" -d 'Dividend history and distribution details for a symbol'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "forecast-eps" -d 'EPS forecasts and analyst consensus estimates for a symbol'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "consensus" -d 'Financial consensus detail for a symbol'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "finance-calendar" -d 'Finance calendar: upcoming events by type (V2)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "valuation" -d 'Valuation analysis: P/E, P/B, P/S, dividend yield, and peer comparison'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "news" -d 'Latest news articles for a symbol, or fetch full article content'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "filing" -d 'Regulatory filings for a symbol, or list/fetch filing content'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "topic" -d 'Community discussion topics'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "watchlist" -d 'List watchlist groups, or create/update/delete a group'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "statement" -d 'Download and export account statements (daily/monthly)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "order" -d 'Order management: list, detail, buy, sell, cancel, replace, executions'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "assets" -d 'Account asset overview — net assets, cash, buy power, margins, and per-currency breakdown'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "cash-flow" -d 'Cash flow records (deposits, withdrawals, dividends, settlements)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "portfolio" -d 'Portfolio overview — total assets, P/L, intraday P/L, holdings, and cash breakdown'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "positions" -d 'Current stock (equity) positions across all sub-accounts'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "fund-positions" -d 'Current fund (mutual fund) positions across all sub-accounts'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "margin-ratio" -d 'Margin ratio requirements for a symbol'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "max-qty" -d 'Estimate maximum buy or sell quantity given current account balance'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "exchange-rate" -d 'Exchange rates for all supported currencies'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "shareholder" -d 'Institutional shareholders for a symbol'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "company" -d 'Company overview (founding date, employees, IPO price, address, etc.)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "executive" -d 'Company executives and key personnel'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "industry-valuation" -d 'Industry valuation comparison and distribution'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "operating" -d 'Operating reviews and financial indicators by report period'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "corp-action" -d 'Corporate actions (splits, dividends, rights, etc.)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "invest-relation" -d 'Investment relations (subsidiary/parent companies)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "constituent" -d 'Index or ETF constituent stocks'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "market-status" -d 'Market open/close status for each exchange'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "broker-holding" -d 'Broker holding positions (HK market only)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "ah-premium" -d 'A/H premium ratio for dual-listed stocks (kline or intraday)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "trade-stats" -d 'Trade statistics (price distribution by volume)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "anomaly" -d 'Quote anomalies / unusual market movements'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "alert" -d 'Price alerts (list, add, delete)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "profit-analysis" -d 'Profit & loss analysis'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "fund-holder" -d 'Funds and ETFs that hold a given symbol'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "insider-trades" -d 'SEC Form 4 insider trades for a US-listed company'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "investors" -d 'View SEC 13F portfolio holdings for institutional investors'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "dca" -d 'Recurring Investment: automatically invest a fixed amount at regular intervals'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "short-positions" -d 'US stock short selling data (short interest, short ratio, days to cover)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "sharelist" -d 'Sharelist: community stock lists — list, detail, create, delete, and manage stocks'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and not __fish_seen_subcommand_from auth check update tui completion quote depth brokers trades intraday kline static calc-index capital market-temp trading security-list participants subscriptions option warrant financial-report institution-rating dividend forecast-eps consensus finance-calendar valuation news filing topic watchlist statement order assets cash-flow portfolio positions fund-positions margin-ratio max-qty exchange-rate shareholder company executive industry-valuation operating corp-action invest-relation constituent market-status broker-holding ah-premium trade-stats anomaly alert profit-analysis fund-holder insider-trades investors dca short-positions sharelist help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from auth" -f -a "login" -d 'Authenticate via Device Authorization Flow (default) or browser OAuth'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from auth" -f -a "logout" -d 'Clear the locally stored OAuth token'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from auth" -f -a "status" -d 'Show authentication status'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from kline" -f -a "history" -d 'Historical OHLCV candlestick data within a date range'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from trading" -f -a "session" -d 'Trading session schedule (open/close times) for all markets'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from trading" -f -a "days" -d 'Trading days and half-trading days for a market'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from option" -f -a "chain" -d 'Option chain: expiry dates, or strike prices for a given expiry'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from option" -f -a "quote" -d 'Real-time quotes for option contracts'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from option" -f -a "volume" -d 'Real-time Call/Put volume snapshot; with `daily` subcommand shows historical data'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from warrant" -f -a "quote" -d 'Real-time quotes for warrant contracts'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from warrant" -f -a "issuers" -d 'Warrant issuer list (HK market)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from institution-rating" -f -a "detail" -d 'Historical institution rating and target price detail'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from dividend" -f -a "detail" -d 'Dividend distribution scheme details'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from news" -f -a "detail" -d 'Full Markdown content of a news article'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from filing" -f -a "detail" -d 'Full Markdown content of a regulatory filing (HTML and TXT only)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from topic" -f -a "detail" -d 'Get full details of a community topic by its ID'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from topic" -f -a "mine" -d 'Topics created by the authenticated user'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from topic" -f -a "create" -d 'Publish a new community discussion topic'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from topic" -f -a "replies" -d 'List replies for a community topic (paginated)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from topic" -f -a "create-reply" -d 'Post a reply to a community topic'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from watchlist" -f -a "show" -d 'Show securities in a specific watchlist group (by ID or name)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from watchlist" -f -a "create" -d 'Create a new watchlist group'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from watchlist" -f -a "delete" -d 'Delete a watchlist group (prompts for confirmation)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from watchlist" -f -a "update" -d 'Add/remove securities in a group, or rename it'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from watchlist" -f -a "pin" -d 'Pin or unpin securities so they appear at the top of a watchlist group'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from statement" -f -a "list" -d 'List available statements for an account'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from statement" -f -a "export" -d 'Export statement sections as CSV files or markdown'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from order" -f -a "detail" -d 'Full detail for a single order including charges and history'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from order" -f -a "executions" -d 'Today\'s trade executions (fills), or historical with --history'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from order" -f -a "buy" -d 'Submit a buy order (prompts for confirmation)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from order" -f -a "sell" -d 'Submit a sell order (prompts for confirmation)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from order" -f -a "cancel" -d 'Cancel a pending order (prompts for confirmation)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from order" -f -a "replace" -d 'Modify quantity or price of a pending order (prompts for confirmation)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from industry-valuation" -f -a "dist" -d 'Industry valuation distribution (percentile ranking)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from broker-holding" -f -a "detail" -d 'Full broker holding detail list'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from broker-holding" -f -a "daily" -d 'Daily holding history for a specific broker'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from ah-premium" -f -a "intraday" -d 'AH premium intraday timeshare data'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from alert" -f -a "add" -d 'Add a price alert'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from alert" -f -a "delete" -d 'Delete a price alert by id (from `longbridge alert` list)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from alert" -f -a "enable" -d 'Enable a price alert by id'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from alert" -f -a "disable" -d 'Disable a price alert by id'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from profit-analysis" -f -a "detail" -d 'Individual stock P&L detail with transaction flows'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from profit-analysis" -f -a "by-market" -d 'Stock P&L by market with pagination'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from investors" -f -a "changes" -d 'Show position changes between two 13F filings (NEW/ADDED/REDUCED/EXITED)'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from dca" -f -a "create" -d 'Create a new recurring investment plan'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from dca" -f -a "update" -d 'Update an existing recurring investment plan'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from dca" -f -a "pause" -d 'Pause a recurring investment plan'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from dca" -f -a "resume" -d 'Resume a paused recurring investment plan'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from dca" -f -a "stop" -d 'Permanently stop a recurring investment plan'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from dca" -f -a "history" -d 'Show trade history for a recurring investment plan'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from dca" -f -a "stats" -d 'Show recurring investment statistics summary'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from dca" -f -a "calc-date" -d 'Calculate the next trade date for given plan parameters'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from dca" -f -a "check" -d 'Check whether symbols support recurring investment'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from dca" -f -a "set-reminder" -d 'Set the pre-trade reminder hours'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from sharelist" -f -a "detail" -d 'Show full details for a sharelist including its constituent stocks'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from sharelist" -f -a "create" -d 'Create a new sharelist'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from sharelist" -f -a "delete" -d 'Delete a sharelist'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from sharelist" -f -a "add" -d 'Add stocks to a sharelist'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from sharelist" -f -a "remove" -d 'Remove stocks from a sharelist'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from sharelist" -f -a "sort" -d 'Reorder the stocks in a sharelist'
complete -c longbridge -n "__fish_longbridge_using_subcommand help; and __fish_seen_subcommand_from sharelist" -f -a "popular" -d 'Get popular (trending) sharelists'
