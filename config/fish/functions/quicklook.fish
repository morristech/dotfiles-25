function quicklook --description Open\ preview\ of\ a\ file\ using\ OS\ X\'s\ Quick\ Look
	qlmanage -p 2> /dev/null $argv
end
