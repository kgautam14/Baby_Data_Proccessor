default: babies-image.amd64-darwin 

babies-image.amd64-darwin : src/babies.sml build.cm src/csc330.sml
	 ml-build build.cm Babies.main babies-image

run: babies-image.amd64-darwin 
	sml @SMLload  babies-image.amd64-darwin  data/babies.txt 1920

test-02: babies-image.amd64-darwin 
	sml @SMLload  babies-image.amd64-darwin  data/babies.txt 1920 < tests/test-02.in > tests/test-02.txt
	diff tests/test-02.expected tests/test-02.txt

test-03: babies-image.amd64-darwin 
	sml @SMLload  babies-image.amd64-darwin  data/babies.txt 1920 < tests/test-03.in > tests/test-03.txt
	diff tests/test-03.expected tests/test-03.txt

test-04: babies-image.amd64-darwin 
	sml @SMLload  babies-image.amd64-darwin  data/babies.txt 1920 < tests/test-04.in > tests/test-04.txt
	diff tests/test-04.expected tests/test-04.txt

test-all: babies-image.amd64-darwin
	sml @SMLload babies-image.amd64-darwin	data/babies.txt 1920 < tests/test_all.txt > tests/test_all_output.txt

test-turtle: babies-image.amd64-darwin
	sml @SMLload babies-image.amd64-darwin Fake/fake_data.txt 1920 < Fake/fake_baby_name.txt > Fake/fout.txt
	diff Fake/fout.txt Fake/fake_output.txt

clean:
	rm -f babies-image.amd64-darwin 
	
