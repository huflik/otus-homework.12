.PHONY: all clean

all: bin/mapper_average bin/reducer_average bin/mapper_variance bin/reducer_variance

bin/mapper_average:
	mkdir -p bin
	g++ -o $@ -g mapper_average.cpp

bin/reducer_average:
	mkdir -p bin
	g++ -o $@ -g reducer_average.cpp

bin/mapper_variance:
	mkdir -p bin
	g++ -o $@ -g mapper_variance.cpp

bin/reducer_variance:
	mkdir -p bin
	g++ -o $@ -g reducer_variance.cpp

clean:
	rm -rf bin output_average output_variance

verify:
	@if [ -f tests/verify_results.sh ]; then \
		chmod +x tests/verify_results.sh; \
		tests/verify_results.sh; \
	else \
		echo "Error: tests/verify_results.sh not found"; \
		exit 1; \
	fi