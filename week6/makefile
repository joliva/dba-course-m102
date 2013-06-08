start:
	./startup.sh

list:
	@ps -A |grep mongo | grep -v grep

stop:
	@for proc in $$(ps -A |grep mongo | grep -v grep | cut -f 1 -d " ") ; do kill $$proc; done

