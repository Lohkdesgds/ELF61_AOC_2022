#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <vector>

/*
0000 0000 0000 0000 - no operation (nop)
0000 11RD DDDD RRRR - add Rd, Rr: Salva no Rd
0001 10RD DDDD RRRR - sub Rd, Rr: Salva no Rd
0100 00RD DDDD RRRR - rem Rd, Rr: Salva no Rd
1110 KKKK DDDD KKKK - ldi Rd, K: escreve o valor K em Rd
0010 11RD DDDD RRRR - mov Rd, Rr: Copia o valor em Rr para Rd
1100 KKKK KKKK KKKK - RJMP K: pula para PC + k + 1
1111 01KK KKKK K001 - BRNE K: pula para PC + k + 1 se Z for zero.
*/

uint16_t convline(const std::string& str)
{
	char instr[16]{}, dest[16]{}, rdd[16]{};
	unsigned AA = 0, BB = 0;
	int got = sscanf_s(str.c_str(), "%s %s %s", instr, (unsigned)sizeof(instr), dest, (unsigned)sizeof(dest), rdd, (unsigned)sizeof(rdd));

	if (strcmp(instr, "nop") == 0) {
		return 0;
	}
	else if (strcmp(instr, "add") == 0) {
		if (got < 3) throw std::runtime_error("AAA");
		AA = atoi(dest + 1) & 0b11111;
		BB = atoi(rdd + 1) & 0b11111;

		//       AAAABBBBCCCCDDDD
		return 0b0000110000000000 | (AA << 4) | ((BB & 0b10000) << 5) | (BB & 0b1111);
	}
	else if (strcmp(instr, "sub") == 0) {
		if (got < 3) throw std::runtime_error("AAA");
		AA = atoi(dest + 1) & 0b11111;
		BB = atoi(rdd + 1) & 0b11111;

		//       AAAABBBBCCCCDDDD
		return 0b0001100000000000 | (AA << 4) | ((BB & 0b10000) << 5) | (BB & 0b1111);
	}
	else if (strcmp(instr, "rem") == 0) {
		if (got < 3) throw std::runtime_error("AAA");
		AA = atoi(dest + 1) & 0b11111;
		BB = atoi(rdd + 1) & 0b11111;

		//       AAAABBBBCCCCDDDD
		return 0b0100000000000000 | (AA << 4) | ((BB & 0b10000) << 5) | (BB & 0b1111);
	}
	else if (strcmp(instr, "ldi") == 0) {
		if (got < 3) throw std::runtime_error("AAA");
		AA = atoi(dest + 1) & 0b1111;
		BB = atoi(rdd + 1) & 0b11111111;

		//       AAAABBBBCCCCDDDD
		return 0b1110000000000000 | (AA << 4) | ((BB & 0b11110000) << 4) | (BB & 0b1111);
	}
	else if (strcmp(instr, "mov") == 0) {
		if (got < 3) throw std::runtime_error("AAA");
		AA = atoi(dest + 1) & 0b11111;
		BB = atoi(rdd + 1) & 0b11111;

		//       AAAABBBBCCCCDDDD
		return 0b0010110000000000 | (AA << 4) | ((BB & 0b10000) << 5) | (BB & 0b1111);
	}
	else if (strcmp(instr, "rjmp") == 0) {
		if (got < 2) throw std::runtime_error("AAA");
		AA = atoi(dest + 1) & 0xFFF;

		//       AAAABBBBCCCCDDDD
		return 0b1100000000000000 | AA;
	}
	else if (strcmp(instr, "brne") == 0) {
		if (got < 2) throw std::runtime_error("AAA");
		AA = atoi(dest + 1) & 0b1111111;

		//       AAAABBBBCCCCDDDD
		return 0b1111010000000001 | (AA << 3);
	}
	else {
		std::cout << "DEU RUIM! Instrucao desconhecida: " << instr << std::endl;
		exit(0);
	}
}

void printfp(uint16_t val, FILE* o)
{
	for (int a = 15; a >= 0; --a)
	{
		if ((val & (1 << a))) fprintf_s(o, "1");
		else fprintf(o, "0");
	}
}


int main(int argc, char* argv[])
{
	std::vector<std::string> lines;
	FILE* fp = nullptr;
	FILE* fo = nullptr;

	if (argc != 2) return 0;

	if (fopen_s(&fp, argv[1], "rb") != 0) {
		std::cout << "Deu ruim" << std::endl;
		return 0;
	}
	if (fopen_s(&fo, "out.bin", "wb") != 0)
	{
		std::cout << "Deu ruim 3" << std::endl;
		return 0;
	}

	{
		std::string buf;
		while (!feof(fp)) {
			int ch = fgetc(fp);
			if (ch < 0) {
				std::cout << "Deu ruim 2" << std::endl;
				break;
			}

			if (ch == '\n' || ch == '\r') {
				if (!buf.empty()) lines.push_back(std::move(buf));
				buf.clear();
			}
			else buf += ch;
		}
		if (!buf.empty()) lines.push_back(std::move(buf));
	}

	std::cout << "Linhas:\n";
	for (const auto& i : lines) std::cout << " -> '" << i << "'\n";

	for (const auto& i : lines) {
		auto val = convline(i);
		printfp(val, fo);
		fputc('\n', fo);
	}

	return 0;
}

