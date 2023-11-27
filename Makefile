all: src/memCap src/memBw src/cpu src/l1i src/l1d src/l3 src/l2

src/memCap: src/memCap.c
	g++ -o src/memCap src/memCap.c

src/memBw: src/memBw.c
	g++ -o src/memBw src/memBw.c

src/cpu: src/cpu.cpp
	g++ -fopenmp -o src/cpu src/cpu.cpp -lpthread -lgomp

src/l1i: src/l1i.c
	g++ -o src/l1i src/l1i.c -lrt

src/l1d: src/l1d.c
	g++ -o src/l1d src/l1d.c -lrt

src/l3: src/l3.c
	g++ -o src/l3 src/l3.c -lrt

src/l2: src/l2.c
	g++ -o src/l2 src/l2.c -lrt

clean:
	rm -f src/memCap src/memBw src/cpu src/l1i src/l1d src/l3 src/l2
