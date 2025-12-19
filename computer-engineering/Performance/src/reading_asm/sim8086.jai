#import "Basic";
#import "File";
#import "Compiler";
#import "String";
#import "Bit_Operations";

IS_LITTLE_ENDIAN :: false;

Opcode :: enum u8 {
	MOV :: 0b100010;
}

ByteRegister :: enum u8 {
	AL :: 0b000;
	CL :: 0b001;
	DL :: 0b010;
	BL :: 0b011;
	AH :: 0b100;
	CH :: 0b101;
	DH :: 0b110;
	BH :: 0b111;
}

WordRegister :: enum u8 {
	AX :: 0b000;
	CX :: 0b001;
	DX :: 0b010;
	BX :: 0b011;
	SP :: 0b100;
	BP :: 0b101;
	SI :: 0b110;
	DI :: 0b111;
}

#run {
	set_build_options_dc(.{ do_output = false });
	options := get_build_options();
  args := options.compile_time_command_line;

	sb: String_Builder;
	for args {
		append(*sb, it);
	}

	filename := builder_to_string(*sb);
	instructions, ok := read_entire_file(filename);
	if !ok {
    log_error("failed to read file: %", filename);
		exit(1);
	}

	assembly: String_Builder;
	print_to_builder(*assembly, "bits 16\n\n");

	while instructions.count > 0 {
		byte_1 := read_u8(*instructions);

		if (byte_1 | ~cast(u8) Opcode.MOV) == ~cast(u8) Opcode.MOV {
			byte_2 := read_u8(*instructions);

			d := 0b0000_0010 & byte_1;
			w := 0b0000_0001 & byte_1;

			mod := (byte_2 >> 6) & 0b011;
			reg := (byte_2 >> 3) & 0b111;
			rm  := (byte_2 >> 0) & 0b111;

			source :string;
			destination :string;
			if w == 0 {
				source = byte_register(reg);
				destination = byte_register(rm);
			} else {
				source = word_register(reg);
				destination = word_register(rm);
			}

			if d == 1 {
				source, destination = destination, source;
			}

			print_to_builder(*assembly, "mov %, %\n", destination, source);
		} else {
			log_error("%", formatInt(byte_1, base=2));
			exit(1);
		}
	}

	write_entire_file(sprint("%_result.asm", filename), builder_to_string(*assembly));
}

byte_register :: (data: u8) -> string {
	result :string;

	if cast(ByteRegister) data == {
	case .AL;
		result = "al";
	case .CL;
		result = "cl";
	case .DL;
		result = "dl";
	case .BL;
		result = "bl";
	case .AH;
		result = "ah";
	case .CH;
		result = "ch";
	case .DH;
		result = "dh";
	case .BH;
		result = "bh";
	case;
		log("data %", formatInt(data, base=2));
		exit(1);
	}

	return result;
}

word_register :: (data: u8) -> string {
	result: string;

	if cast(WordRegister) data == {
	case .AX;
		result = "ax";
	case .CX;
		result = "cx";
	case .DX;
		result = "dx";
	case .BX;
		result = "bx";
	case .SP;
		result = "sp";
	case .BP;
		result = "bp";
	case .SI;
		result = "si";
	case .DI;
		result = "di";
	case;
		log_error("data %", formatInt(data, base=2));
		exit(1);
	}

	return result;
}

read_u8 :: inline (s: *string) -> u8 {
	assert(s.count >= 1);

	result := << s.data;

	#if !IS_LITTLE_ENDIAN {
		result = byte_swap(result);
	}

	advance(s, 1);
	return result;
}

read_u16 :: inline (s: *string) -> u16 {
	assert(s.count >= 2);

	result := << cast(*u16)s.data;

	#if !IS_LITTLE_ENDIAN {
		result = byte_swap(result);
	}

	advance(s, 2);
	return result;
}
