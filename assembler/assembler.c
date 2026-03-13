#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char* get_opcode(const char* mnemonic) {
    if (strcmp(mnemonic, "ADD") == 0) return "0000";
    if (strcmp(mnemonic, "SUB") == 0) return "0001";
    if (strcmp(mnemonic, "AND") == 0) return "0010";
    if (strcmp(mnemonic, "OR" ) == 0) return "0011";
    if (strcmp(mnemonic, "XOR") == 0) return "0100";
    if (strcmp(mnemonic, "NOT") == 0) return "0101";
    if (strcmp(mnemonic, "SHL") == 0) return "0110";
    if (strcmp(mnemonic, "SHR") == 0) return "0111";
    if (strcmp(mnemonic, "SLT") == 0) return "1000";
    if (strcmp(mnemonic, "LW" ) == 0) return "1001";
    if (strcmp(mnemonic, "SW" ) == 0) return "1010";
    if (strcmp(mnemonic, "LOADI") == 0) return "1011";
    if (strcmp(mnemonic, "JUMP" ) == 0) return "1100";
    return NULL;
}

const char* get_register(const char* reg) {
    if(strcmp(reg, "R0") == 0) return "000";
    if(strcmp(reg, "R1") == 0) return "001";
    if(strcmp(reg, "R2") == 0) return "010";
    if(strcmp(reg, "R3") == 0) return "011";
    if(strcmp(reg, "R4") == 0) return "100";
    if(strcmp(reg, "R5") == 0) return "101";
    if(strcmp(reg, "R6") == 0) return "110";
    if(strcmp(reg, "R7") == 0) return "111";
    return NULL;
}

void clean_token(char* token) {
    int i = 0, j = 0;
    while (token[i]) {
        if (token[i] != ',' && token[i] != ' ' && token[i] != '\n') {
            token[j++] = token[i];
        }
        i++;
    }
    token[j] = '\0';
}

void int_to_bits(int valuea, int num_bits,char* output) {
    for (int i = num_bits -1; i >= 0; i--) {
        output[num_bits - 1 - i] = (valuea >> i & 1) ? '1' : '0';
    }
    output[num_bits] = '\0';
}



int main (int argc, char* argv[]) {

    const char* input_file = "program.asm";
    const char* output_file = (argc > 2) ? argv[2] : "../program/program.mem";

    FILE* input = fopen(input_file, "r");
    FILE* output = fopen(output_file, "w");

    if (!input || !output) {
        fprintf(stderr, "Error opening input or output files.\n");
        return 1;
    }

    printf("Assembling %s into %s...\n\n", input_file, output_file);
    char line[256];
    int line_number = 0;
    int instruction_count = 0;

    while (fgets(line, sizeof(line), input)) {
        line_number++;

        char trimmed[256];
        sscanf(line, "%255s[^\n]", trimmed);
        if(trimmed[0] == '\0' || trimmed[0] == '\n' || trimmed[0] == '/') continue;

        char mnemonic[16] = {0};
        char t1[16] = {0}, t2[16] = {0}, t3[16] = {0};
        int token_count = sscanf(line, "%s %s %s %s", mnemonic, t1, t2, t3);
        clean_token(mnemonic);
        clean_token(t1);
        clean_token(t2);
        clean_token(t3);

        const char* opcode = get_opcode(mnemonic);
        if(!opcode) {
            fprintf(stderr, "Error on line %d: Unknown instruction '%s'\n", line_number, mnemonic);
            continue;
        }
        char instruction[17] = {0};

        //load R1, R2
        if(strcmp(mnemonic, "LOADI") == 0) {
          const char* dst = get_register(t1);
          if(!dst) {
              fprintf(stderr, "Error on line %d: Invalid register '%s'\n", line_number, t1);
              continue;
          }
          int immediate = atoi(t2);
          if(immediate < 0 || immediate > 7) {
              fprintf(stderr, "Error on line %d: Immediate value must be between 0 and 7, got %d\n", line_number, immediate);
              continue;
          }
          char imm_bits[4];
          int_to_bits(immediate, 3, imm_bits);
          // format: [15:12] opcode, [11:9] dst, [8:6] unused, [5:3] unused, [2:0] immediate
          sprintf(instruction, "%s%s%s%s%s", opcode, dst, "000", "000", imm_bits);

          //jump address
        } else if(strcmp(mnemonic, "JUMP") == 0) {
            int address = atoi(t1);
            char addr_bits[13];
            int_to_bits(address, 12, addr_bits);
            // format: [15:12] opcode, [11:0] address
            sprintf(instruction, "%s%s", opcode, addr_bits);

            //NOT DST, R1
        } else if (strcmp(mnemonic, "NOT") == 0) {
            const char* dst = get_register(t1);
            const char* src = get_register(t2);
            if(!dst || !src) {
                fprintf(stderr, "Error on line %d: Invalid register '%s' or '%s'\n", line_number, t1, t2);
                continue;
            }
                // format: [15:12] opcode, [11:9] dst, [8:6] src, [5:0] unused
            sprintf(instruction, "%s%s%s%s", opcode, dst, src, "000000");
        
            // OP DST, SRC1, SRC2
        } else {
            if (token_count < 4) {
                printf("Error on line %d: Expected 3 operands for '%s', got %d\n", line_number, mnemonic, token_count - 1);
                continue;
            }
            const char* dst = get_register(t1);
            const char* src1 = get_register(t2);
            const char* src2 = get_register(t3);
            if(!dst || !src1 || !src2) {
                fprintf(stderr, "Error on line %d: Invalid register '%s', '%s' or '%s'\n", line_number, t1, t2, t3);
                continue;
            }
            // format: [15:12] opcode, [11:9] dst, [8:6] src1, [5:3] src2, [2:0] unused
            sprintf(instruction, "%s%s%s%s%s", opcode, dst, src1, src2, "000");
        }
        fprintf(output, "%s\n", instruction);
        printf("   [%02d] %-25s -> %s\n", instruction_count, trimmed, instruction);
        instruction_count++;
    }
    fclose(input);
    fclose(output);
    printf("\nAssembly complete! %d instructions written to %s\n", instruction_count, output_file);
    return 0;
}