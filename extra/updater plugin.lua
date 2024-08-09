-- Author: @Jumpathy
-- Name: plugin.lua
-- Description: Auto-update better chat
local toolbar = plugin:CreateToolbar("BetterChat")
local toggleAutoUpdates = toolbar:CreateButton("Toggle Auto-Update", "Toggles the auto updating feature, studio only", "rbxassetid://6031225810")
local add = toolbar:CreateButton("Install", "Install better chat", "rbxassetid://6035047375")
local rewrite = toolbar:CreateButton("Overwrite","Overwrite the current source code","rbxassetid://6031360355")

local compressionModule = function()
	--[[
	-------------------------------
	---       INFORMATION       ---
	-------------------------------
	
	Written by Haoqian He
	Edited/Forked by Scarious
	
	This is the forked version of the LibDeflate library by Haoqian He intended for luau. Credit for the original source code and such
	goes to their respective creators (basic credits can be viewed under CREDITS, and more expansive credits/licensing info can be viewed
	under LICENSING AND COPYRIGHT.
	
	Original documentation can be viewed here: https://safeteewow.github.io/LibDeflate/source/LibDeflate.lua.html
	
	You can access the LibDeflate library (and most LibDeflate methods seen in the original documentation) by using Compression.Library
	
	
	-------------------------------
	---      DOCUMENTATION      ---
	-------------------------------
	
	Compression Methods:
	
	Compression.Deflate.Compress(data, configs?)
	Compression.Zlib.Compress(data, configs?)
	
	
	Decompression Methods:
	
	Compression.Deflate.Decompress(compressedData)
	Compression.Zlib.Decompress(compressedData)
	
	
	USAGE:
	
		configs table:
	
		{
			level = 0; -- integer 0 -> 9 where 0 is no compression and 9 is most compression
			strategy = "" -- "huffman_only", "fixed", "dynamic"
		}
		
		note :: the higher the level, the slower the compression will be
			 :: configs table is optional, if not supplied (aka nil) default level+strategy will be used
			 
		
		methods:
		
		Method: Compression.Deflate.Compress(data, configs?):
	
			Description: Compresses a string using the raw deflate format
			
			Input:
				- String: data = The data to be compressed
				- table?: configs = The configuration table to control the compression
				
			Output:
				- String: compressedData = The compressed data
				- int: paddedBits = The number of bits padded at the end of the output


		Method: Compression.Deflate.Decompress(compressedData):
	
			Description: Decompresses a raw deflate compressed data.
			
			Input:
				- String: compressedData = The data to be decompressed
				
			Output:
				- String: data = The decompressed data



		Method: Compression.Zlib.Compress(data, configs?):
	
			Description: Compresses a string using the zlib format
			
			Input:
				- String: data = The data to be compressed
				- table?: configs = The configuration table to control the compression
				
			Output:
				- String: compressedData = The compressed data
				- int: paddedBits = The number of bits padded at the end of the output
		
		
		Method: Compression.Deflate.Decompress(compressedData):
	
			Description: Decompresses a zlib compressed data.
			
			Input:
				- String: compressedData = The data to be decompressed
				
			Output:
				- String: data = The decompressed data
		
		
	-------------------------------
	---         CREDITS         ---
	-------------------------------
	
	- LibDeflate Library: Haoqian He
	- zlib: Jean-loup Gailly and Mark Adler
	- puff: Mark Adler
	- LibCompress: jjsheets and Galmok (WoW)
	- 6bit encoding/decoding: WeakAuras2 (WoW)
	

	-------------------------------
	--- LICENSING AND COPYRIGHT ---
	-------------------------------

	LibDeflate 1.0.2-release <br>
	Pure Lua compressor and decompressor with high compression ratio using
	DEFLATE/zlib format.
	@file LibDeflate.lua
	@author Haoqian He (Github: SafeteeWoW; World of Warcraft: Safetyy-Illidan(US))
	@copyright LibDeflate <2018-2020> Haoqian He
	@license zlib License
	This library is implemented according to the following specifications.
	Report a bug if LibDeflate is not fully compliant with those specs.
	Both compressors and decompressors have been implemented in the library.
	1. RFC1950: DEFLATE Compressed Data Format Specification version 1.3
	https://tools.ietf.org/html/rfc1951
	2. RFC1951: ZLIB Compressed Data Format Specification version 3.3
	https://tools.ietf.org/html/rfc1950


	zlib License
	(C) 2018-2020 Haoqian He
	This software is provided 'as-is', without any express or implied
	warranty.  In no event will the authors be held liable for any damages
	arising from the use of this software.
	Permission is granted to anyone to use this software for any purpose,
	including commercial applications, and to alter it and redistribute it
	freely, subject to the following restrictions:
	1. The origin of this software must not be misrepresented; you must not
	   claim that you wrote the original software. If you use this software
	   in a product, an acknowledgment in the product documentation would be
	   appreciated but is not required.
	2. Altered source versions must be plainly marked as such, and must not be
	   misrepresented as being the original software.
	3. This notice may not be removed or altered from any source distribution.
	License History:
		1. GNU General Public License Version 3 in v1.0.0 and earlier versions.
		2. GNU Lesser General Public License Version 3 in v1.0.1
		3. the zlib License since v1.0.2
		
	Credits and Disclaimer:
	This library rewrites the code from the algorithm
	and the ideas of the following projects,
	and uses their code to help to test the correctness of this library,
	but their code is not included directly in the library itself.
	Their original licenses shall be comply when used:
		1. zlib, by Jean-loup Gailly (compression) and Mark Adler (decompression).
			http://www.zlib.net/
			Licensed under zlib License. http://www.zlib.net/zlib_license.html
			For the compression algorithm.
		2. puff, by Mark Adler. https://github.com/madler/zlib/tree/master/contrib/puff
			Licensed under zlib License. http://www.zlib.net/zlib_license.html
			For the decompression algorithm.
		3. LibCompress, by jjsheets and Galmok of European Stormrage (Horde)
			https://www.wowace.com/projects/libcompress
			Licensed under GPLv2.
			https://www.gnu.org/licenses/old-licenses/gpl-2.0.html
			For the code to create customized codec.
		4. WeakAuras2,
			https://github.com/WeakAuras/WeakAuras2
			Licensed under GPLv2.
			For the 6bit encoding and decoding.
]]

	local Compression = {}
	local LibDeflate = {}

	Compression.Deflate = {}
	Compression.Zlib = {}
	Compression.Library = LibDeflate

--[[
	Method: Compression.Deflate.Compress
	
	Description: Compresses a string using the raw deflate format
	
	Input:
		- String: data = The data to be compressed
		- table?: configs = The configuration table to control the compression
		
	Output:
		- String: compressedData = The compressed data
		- int: paddedBits = The number of bits padded at the end of the output
		
	For more information see:
		- LibDeflate:CompressDeflate
		- compression_configs
]]

	function Compression.Deflate.Compress(data, configs)
		return LibDeflate:CompressDeflate(data, configs)
	end


--[[
	Method: Compression.Deflate.Decompress
	
	Description: Decompresses a raw deflate compressed data.
	
	Input:
		- String: compressedData = The data to be decompressed
		
	Output:
		- String: data = The decompressed data
		
	For more information see:
		- LibDeflate:DecompressDeflate
		- compression_configs
]]

	function Compression.Deflate.Decompress(compressedData)
		return LibDeflate:DecompressDeflate(compressedData)
	end



--[[
	Method: Compression.Zlib.Compress
	
	Description: Compresses a string using the zlib format
	
	Input:
		- String: data = The data to be compressed
		- table?: configs = The configuration table to control the compression
		
	Output:
		- String: compressedData = The compressed data
		- int: paddedBits = The number of bits padded at the end of the output
		
	For more information see:
		- LibDeflate:CompressZlib
		- compression_configs
]]

	function Compression.Zlib.Compress(data, configs)
		return LibDeflate:CompressZlib(data, configs)
	end


--[[
	Method: Compression.Deflate.Decompress
	
	Description: Decompresses a zlib compressed data.
	
	Input:
		- String: compressedData = The data to be decompressed
		
	Output:
		- String: data = The decompressed data
		
	For more information see:
		- LibDeflate:DecompressZlib
		- compression_configs
]]

	function Compression.Zlib.Decompress(compressedData)
		return LibDeflate:DecompressZlib(compressedData)
	end





--[[

	LIBDEFLATE LIBRARY:

]]


	do
		-- Semantic version. all lowercase.
		-- Suffix can be alpha1, alpha2, beta1, beta2, rc1, rc2, etc.
		-- NOTE: Two version numbers needs to modify.
		-- 1. On the top of LibDeflate.lua
		-- 2. _VERSION
		-- 3. _MINOR

		-- version to store the official version of LibDeflate
		local _VERSION = "1.0.2-release"

		-- When MAJOR is changed, I should name it as LibDeflate2
		local _MAJOR = "LibDeflate"

		-- Update this whenever a new version, for LibStub version registration.
		-- 0 : v0.x
		-- 1 : v1.0.0
		-- 2 : v1.0.1
		-- 3 : v1.0.2
		local _MINOR = 3

		local _COPYRIGHT =
			"LibDeflate ".._VERSION
			.." Copyright (C) 2018-2020 Haoqian He."
			.." Licensed under the zlib License"

		-- Register in the World of Warcraft library "LibStub" if detected.
		LibDeflate = {}

		LibDeflate._VERSION = _VERSION
		LibDeflate._MAJOR = _MAJOR
		LibDeflate._MINOR = _MINOR
		LibDeflate._COPYRIGHT = _COPYRIGHT
	end

	-- localize Lua api for faster access.
	local assert = assert
	local error = error
	local pairs = pairs
	local string_byte = string.byte
	local string_char = string.char
	local string_find = string.find
	local string_gsub = string.gsub
	local string_sub = string.sub
	local table_concat = table.concat
	local table_sort = table.sort
	local tostring = tostring
	local type = type

	-- Converts i to 2^i, (0<=i<=32)
	-- This is used to implement bit left shift and bit right shift.
	-- "x >> y" in C:   "(x-x%_pow2[y])/_pow2[y]" in Lua
	-- "x << y" in C:   "x*_pow2[y]" in Lua
	local _pow2 = {}

	-- Converts any byte to a character, (0<=byte<=255)
	local _byte_to_char = {}

	-- _reverseBitsTbl[len][val] stores the bit reverse of
	-- the number with bit length "len" and value "val"
	-- For example, decimal number 6 with bits length 5 is binary 00110
	-- It's reverse is binary 01100,
	-- which is decimal 12 and 12 == _reverseBitsTbl[5][6]
	-- 1<=len<=9, 0<=val<=2^len-1
	-- The reason for 1<=len<=9 is that the max of min bitlen of huffman code
	-- of a huffman alphabet is 9?
	local _reverse_bits_tbl = {}

	-- Convert a LZ77 length (3<=len<=258) to
	-- a deflate literal/LZ77_length code (257<=code<=285)
	local _length_to_deflate_code = {}

	-- convert a LZ77 length (3<=len<=258) to
	-- a deflate literal/LZ77_length code extra bits.
	local _length_to_deflate_extra_bits = {}

	-- Convert a LZ77 length (3<=len<=258) to
	-- a deflate literal/LZ77_length code extra bit length.
	local _length_to_deflate_extra_bitlen = {}

	-- Convert a small LZ77 distance (1<=dist<=256) to a deflate code.
	local _dist256_to_deflate_code = {}

	-- Convert a small LZ77 distance (1<=dist<=256) to
	-- a deflate distance code extra bits.
	local _dist256_to_deflate_extra_bits = {}

	-- Convert a small LZ77 distance (1<=dist<=256) to
	-- a deflate distance code extra bit length.
	local _dist256_to_deflate_extra_bitlen = {}

	-- Convert a literal/LZ77_length deflate code to LZ77 base length
	-- The key of the table is (code - 256), 257<=code<=285
	local _literal_deflate_code_to_base_len = {
		3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31,
		35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258,
	}

	-- Convert a literal/LZ77_length deflate code to base LZ77 length extra bits
	-- The key of the table is (code - 256), 257<=code<=285
	local _literal_deflate_code_to_extra_bitlen = {
		0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2,
		3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0,
	}

	-- Convert a distance deflate code to base LZ77 distance. (0<=code<=29)
	local _dist_deflate_code_to_base_dist = {
		[0] = 1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193,
		257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145,
		8193, 12289, 16385, 24577,
	}

	-- Convert a distance deflate code to LZ77 bits length. (0<=code<=29)
	local _dist_deflate_code_to_extra_bitlen = {
		[0] = 0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6,
		7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13,
	}

	-- The code order of the first huffman header in the dynamic deflate block.
	-- See the page 12 of RFC1951
	local _rle_codes_huffman_bitlen_order = {16, 17, 18,
		0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15,
	}

	-- The following tables are used by fixed deflate block.
	-- The value of these tables are assigned at the bottom of the source.

	-- The huffman code of the literal/LZ77_length deflate codes,
	-- in fixed deflate block.
	local _fix_block_literal_huffman_code

	-- Convert huffman code of the literal/LZ77_length to deflate codes,
	-- in fixed deflate block.
	local _fix_block_literal_huffman_to_deflate_code

	-- The bit length of the huffman code of literal/LZ77_length deflate codes,
	-- in fixed deflate block.
	local _fix_block_literal_huffman_bitlen

	-- The count of each bit length of the literal/LZ77_length deflate codes,
	-- in fixed deflate block.
	local _fix_block_literal_huffman_bitlen_count

	-- The huffman code of the distance deflate codes,
	-- in fixed deflate block.
	local _fix_block_dist_huffman_code

	-- Convert huffman code of the distance to deflate codes,
	-- in fixed deflate block.
	local _fix_block_dist_huffman_to_deflate_code

	-- The bit length of the huffman code of the distance deflate codes,
	-- in fixed deflate block.
	local _fix_block_dist_huffman_bitlen

	-- The count of each bit length of the huffman code of
	-- the distance deflate codes,
	-- in fixed deflate block.
	local _fix_block_dist_huffman_bitlen_count

	for i = 0, 255 do
		_byte_to_char[i] = string_char(i)
	end

	do
		local pow = 1
		for i = 0, 32 do
			_pow2[i] = pow
			pow = pow * 2
		end
	end

	for i = 1, 9 do
		_reverse_bits_tbl[i] = {}
		for j=0, _pow2[i+1]-1 do
			local reverse = 0
			local value = j
			for _ = 1, i do
				-- The following line is equivalent to "res | (code %2)" in C.
				reverse = reverse - reverse%2
					+ (((reverse%2==1) or (value % 2) == 1) and 1 or 0)
				value = (value-value%2)/2
				reverse = reverse * 2
			end
			_reverse_bits_tbl[i][j] = (reverse-reverse%2)/2
		end
	end

	-- The source code is written according to the pattern in the numbers
	-- in RFC1951 Page10.
	do
		local a = 18
		local b = 16
		local c = 265
		local bitlen = 1
		for len = 3, 258 do
			if len <= 10 then
				_length_to_deflate_code[len] = len + 254
				_length_to_deflate_extra_bitlen[len] = 0
			elseif len == 258 then
				_length_to_deflate_code[len] = 285
				_length_to_deflate_extra_bitlen[len] = 0
			else
				if len > a then
					a = a + b
					b = b * 2
					c = c + 4
					bitlen = bitlen + 1
				end
				local t = len-a-1+b/2
				_length_to_deflate_code[len] = (t-(t%(b/8)))/(b/8) + c
				_length_to_deflate_extra_bitlen[len] = bitlen
				_length_to_deflate_extra_bits[len] = t % (b/8)
			end
		end
	end

	-- The source code is written according to the pattern in the numbers
	-- in RFC1951 Page11.
	do
		_dist256_to_deflate_code[1] = 0
		_dist256_to_deflate_code[2] = 1
		_dist256_to_deflate_extra_bitlen[1] = 0
		_dist256_to_deflate_extra_bitlen[2] = 0

		local a = 3
		local b = 4
		local code = 2
		local bitlen = 0
		for dist = 3, 256 do
			if dist > b then
				a = a * 2
				b = b * 2
				code = code + 2
				bitlen = bitlen + 1
			end
			_dist256_to_deflate_code[dist] = (dist <= a) and code or (code+1)
			_dist256_to_deflate_extra_bitlen[dist] = (bitlen < 0) and 0 or bitlen
			if b >= 8 then
				_dist256_to_deflate_extra_bits[dist] = (dist-b/2-1) % (b/4)
			end
		end
	end

	--- Calculate the Adler-32 checksum of the string. <br>
	-- See RFC1950 Page 9 https://tools.ietf.org/html/rfc1950 for the
	-- definition of Adler-32 checksum.
	-- @param str [string] the input string to calcuate its Adler-32 checksum.
	-- @return [integer] The Adler-32 checksum, which is greater or equal to 0,
	-- and less than 2^32 (4294967296).
	function LibDeflate:Adler32(str)
		-- This function is loop unrolled by better performance.
		--
		-- Here is the minimum code:
		--
		-- local a = 1
		-- local b = 0
		-- for i=1, #str do
		-- 		local s = string.byte(str, i, i)
		-- 		a = (a+s)%65521
		-- 		b = (b+a)%65521
		-- 		end
		-- return b*65536+a
		if type(str) ~= "string" then
			error(("Usage: LibDeflate:Adler32(str):"
				.." 'str' - string expected got '%s'."):format(type(str)), 2)
		end
		local strlen = #str

		local i = 1
		local a = 1
		local b = 0
		while i <= strlen - 15 do
			local x1, x2, x3, x4, x5, x6, x7, x8,
			x9, x10, x11, x12, x13, x14, x15, x16 = string_byte(str, i, i+15)
			b = (b+16*a+16*x1+15*x2+14*x3+13*x4+12*x5+11*x6+10*x7+9*x8+8*x9
				+7*x10+6*x11+5*x12+4*x13+3*x14+2*x15+x16)%65521
			a = (a+x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+x11+x12+x13+x14+x15+x16)%65521
			i =  i + 16
		end
		while (i <= strlen) do
			local x = string_byte(str, i, i)
			a = (a + x) % 65521
			b = (b + a) % 65521
			i = i + 1
		end
		return (b*65536+a) % 4294967296
	end

	-- Compare adler32 checksum.
	-- adler32 should be compared with a mod to avoid sign problem
	-- 4072834167 (unsigned) is the same adler32 as -222133129
	local function IsEqualAdler32(actual, expected)
		return (actual % 4294967296) == (expected % 4294967296)
	end

	--- Create a preset dictionary.
	--
	-- This function is not fast, and the memory consumption of the produced
	-- dictionary is about 50 times of the input string. Therefore, it is suggestted
	-- to run this function only once in your program.
	--
	-- It is very important to know that if you do use a preset dictionary,
	-- compressors and decompressors MUST USE THE SAME dictionary. That is,
	-- dictionary must be created using the same string. If you update your program
	-- with a new dictionary, people with the old version won't be able to transmit
	-- data with people with the new version. Therefore, changing the dictionary
	-- must be very careful.
	--
	-- The parameters "strlen" and "adler32" add a layer of verification to ensure
	-- the parameter "str" is not modified unintentionally during the program
	-- development.
	--
	-- @usage local dict_str = "1234567890"
	--
	-- -- print(dict_str:len(), LibDeflate:Adler32(dict_str))
	-- -- Hardcode the print result below to verify it to avoid acciently
	-- -- modification of 'str' during the program development.
	-- -- string length: 10, Adler-32: 187433486,
	-- -- Don't calculate string length and its Adler-32 at run-time.
	--
	-- local dict = LibDeflate:CreateDictionary(dict_str, 10, 187433486)
	--
	-- @param str [string] The string used as the preset dictionary. <br>
	-- You should put stuffs that frequently appears in the dictionary
	-- string and preferablely put more frequently appeared stuffs toward the end
	-- of the string. <br>
	-- Empty string and string longer than 32768 bytes are not allowed.
	-- @param strlen [integer] The length of 'str'. Please pass in this parameter
	-- as a hardcoded constant, in order to verify the content of 'str'. The value
	-- of this parameter should be known before your program runs.
	-- @param adler32 [integer] The Adler-32 checksum of 'str'. Please pass in this
	-- parameter as a hardcoded constant, in order to verify the content of 'str'.
	-- The value of this parameter should be known before your program runs.
	-- @return  [table] The dictionary used for preset dictionary compression and
	-- decompression.
	-- @raise error if 'strlen' does not match the length of 'str',
	-- or if 'adler32' does not match the Adler-32 checksum of 'str'.
	function LibDeflate:CreateDictionary(str, strlen, adler32)
		if type(str) ~= "string" then
			error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):"
				.." 'str' - string expected got '%s'."):format(type(str)), 2)
		end
		if type(strlen) ~= "number" then
			error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):"
				.." 'strlen' - number expected got '%s'."):format(
					type(strlen)), 2)
		end
		if type(adler32) ~= "number" then
			error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):"
				.." 'adler32' - number expected got '%s'."):format(
					type(adler32)), 2)
		end
		if strlen ~= #str then
			error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):"
				.." 'strlen' does not match the actual length of 'str'."
				.." 'strlen': %u, '#str': %u ."
				.." Please check if 'str' is modified unintentionally.")
				:format(strlen, #str))
		end
		if strlen == 0 then
			error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):"
				.." 'str' - Empty string is not allowed."), 2)
		end
		if strlen > 32768 then
			error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):"
				.." 'str' - string longer than 32768 bytes is not allowed."
				.." Got %d bytes."):format(strlen), 2)
		end
		local actual_adler32 = self:Adler32(str)
		if not IsEqualAdler32(adler32, actual_adler32) then
			error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32):"
				.." 'adler32' does not match the actual adler32 of 'str'."
				.." 'adler32': %u, 'Adler32(str)': %u ."
				.." Please check if 'str' is modified unintentionally.")
				:format(adler32, actual_adler32))
		end

		local dictionary = {}
		dictionary.adler32 = adler32
		dictionary.hash_tables = {}
		dictionary.string_table = {}
		dictionary.strlen = strlen
		local string_table = dictionary.string_table
		local hash_tables = dictionary.hash_tables
		string_table[1] = string_byte(str, 1, 1)
		string_table[2] = string_byte(str, 2, 2)
		if strlen >= 3 then
			local i = 1
			local hash = string_table[1]*256+string_table[2]
			while i <= strlen - 2 - 3 do
				local x1, x2, x3, x4 = string_byte(str, i+2, i+5)
				string_table[i+2] = x1
				string_table[i+3] = x2
				string_table[i+4] = x3
				string_table[i+5] = x4
				hash = (hash*256+x1)%16777216
				local t = hash_tables[hash]
				if not t then t = {}; hash_tables[hash] = t end
				t[#t+1] = i-strlen
				i = i + 1
				hash = (hash*256+x2)%16777216
				t = hash_tables[hash]
				if not t then t = {}; hash_tables[hash] = t end
				t[#t+1] = i-strlen
				i = i + 1
				hash = (hash*256+x3)%16777216
				t = hash_tables[hash]
				if not t then t = {}; hash_tables[hash] = t end
				t[#t+1] = i-strlen
				i = i + 1
				hash = (hash*256+x4)%16777216
				t = hash_tables[hash]
				if not t then t = {}; hash_tables[hash] = t end
				t[#t+1] = i-strlen
				i = i + 1
			end
			while i <= strlen - 2 do
				local x = string_byte(str, i+2)
				string_table[i+2] = x
				hash = (hash*256+x)%16777216
				local t = hash_tables[hash]
				if not t then t = {}; hash_tables[hash] = t end
				t[#t+1] = i-strlen
				i = i + 1
			end
		end
		return dictionary
	end

	-- Check if the dictionary is valid.
	-- @param dictionary The preset dictionary for compression and decompression.
	-- @return true if valid, false if not valid.
	-- @return if not valid, the error message.
	local function IsValidDictionary(dictionary)
		if type(dictionary) ~= "table" then
			return false, ("'dictionary' - table expected got '%s'.")
				:format(type(dictionary))
		end
		if type(dictionary.adler32) ~= "number"
			or type(dictionary.string_table) ~= "table"
			or type(dictionary.strlen) ~= "number"
			or dictionary.strlen <= 0
			or dictionary.strlen > 32768
			or dictionary.strlen ~= #dictionary.string_table
			or type(dictionary.hash_tables) ~= "table"
		then
			return false, ("'dictionary' - corrupted dictionary.")
				:format(type(dictionary))
		end
		return true, ""
	end

--[[
	key of the configuration table is the compression level,
	and its value stores the compression setting.
	These numbers come from zlib source code.
	Higher compression level usually means better compression.
	(Because LibDeflate uses a simplified version of zlib algorithm,
	there is no guarantee that higher compression level does not create
	bigger file than lower level, but I can say it's 99% likely)
	Be careful with the high compression level. This is a pure lua
	implementation compressor/decompressor, which is significant slower than
	a C/C++ equivalant compressor/decompressor. Very high compression level
	costs significant more CPU time, and usually compression size won't be
	significant smaller when you increase compression level by 1, when the
	level is already very high. Benchmark yourself if you can afford it.
	See also https://github.com/madler/zlib/blob/master/doc/algorithm.txt,
	https://github.com/madler/zlib/blob/master/deflate.c for more information.
	The meaning of each field:
	@field 1 use_lazy_evaluation:
		true/false. Whether the program uses lazy evaluation.
		See what is "lazy evaluation" in the link above.
		lazy_evaluation improves ratio, but relatively slow.
	@field 2 good_prev_length:
		Only effective if lazy is set, Only use 1/4 of max_chain,
		if prev length of lazy match is above this.
	@field 3 max_insert_length/max_lazy_match:
		If not using lazy evaluation,
		insert new strings in the hash table only if the match length is not
		greater than this length.
		If using lazy evaluation, only continue lazy evaluation,
		if previous match length is strictly smaller than this value.
	@field 4 nice_length:
		Number. Don't continue to go down the hash chain,
		if match length is above this.
	@field 5 max_chain:
		Number. The maximum number of hash chains we look.
--]]
	local _compression_level_configs = {
		[0] = {false, nil, 0, 0, 0}, -- level 0, no compression
		[1] = {false, nil, 4, 8, 4}, -- level 1, similar to zlib level 1
		[2] = {false, nil, 5, 18, 8}, -- level 2, similar to zlib level 2
		[3] = {false, nil, 6, 32, 32},	-- level 3, similar to zlib level 3
		[4] = {true, 4,	4, 16, 16},	-- level 4, similar to zlib level 4
		[5] = {true, 8,	16,	32,	32}, -- level 5, similar to zlib level 5
		[6] = {true, 8,	16,	128, 128}, -- level 6, similar to zlib level 6
		[7] = {true, 8,	32,	128, 256}, -- (SLOW) level 7, similar to zlib level 7
		[8] = {true, 32, 128, 258, 1024} , --(SLOW) level 8,similar to zlib level 8
		[9] = {true, 32, 258, 258, 4096},
		-- (VERY SLOW) level 9, similar to zlib level 9
	}

	-- Check if the compression/decompression arguments is valid
	-- @param str The input string.
	-- @param check_dictionary if true, check if dictionary is valid.
	-- @param dictionary The preset dictionary for compression and decompression.
	-- @param check_configs if true, check if config is valid.
	-- @param configs The compression configuration table
	-- @return true if valid, false if not valid.
	-- @return if not valid, the error message.
	local function IsValidArguments(str,
		check_dictionary, dictionary,
		check_configs, configs)

		if type(str) ~= "string" then
			return false,
			("'str' - string expected got '%s'."):format(type(str))
		end
		if check_dictionary then
			local dict_valid, dict_err = IsValidDictionary(dictionary)
			if not dict_valid then
				return false, dict_err
			end
		end
		if check_configs then
			local type_configs = type(configs)
			if type_configs ~= "nil" and type_configs ~= "table" then
				return false,
				("'configs' - nil or table expected got '%s'.")
					:format(type(configs))
			end
			if type_configs == "table" then
				for k, v in pairs(configs) do
					if k ~= "level" and k ~= "strategy" then
						return false,
						("'configs' - unsupported table key in the configs: '%s'.")
							:format(k)
					elseif k == "level" and not _compression_level_configs[v] then
						return false,
						("'configs' - unsupported 'level': %s."):format(tostring(v))
					elseif k == "strategy" and v ~= "fixed" and v ~= "huffman_only"
						and v ~= "dynamic" then
						-- random_block_type is for testing purpose
						return false, ("'configs' - unsupported 'strategy': '%s'.")
							:format(tostring(v))
					end
				end
			end
		end
		return true, ""
	end



--[[ --------------------------------------------------------------------------
	Compress code
--]] --------------------------------------------------------------------------

	-- partial flush to save memory
	local _FLUSH_MODE_MEMORY_CLEANUP = 0
	-- full flush with partial bytes
	local _FLUSH_MODE_OUTPUT = 1
	-- write bytes to get to byte boundary
	local _FLUSH_MODE_BYTE_BOUNDARY = 2
	-- no flush, just get num of bits written so far
	local _FLUSH_MODE_NO_FLUSH = 3

--[[
	Create an empty writer to easily write stuffs as the unit of bits.
	Return values:
	1. WriteBits(code, bitlen):
	2. WriteString(str):
	3. Flush(mode):
--]]
	local function CreateWriter()
		local buffer_size = 0
		local cache = 0
		local cache_bitlen = 0
		local total_bitlen = 0
		local buffer = {}
		-- When buffer is big enough, flush into result_buffer to save memory.
		local result_buffer = {}

		-- Write bits with value "value" and bit length of "bitlen" into writer.
		-- @param value: The value being written
		-- @param bitlen: The bit length of "value"
		-- @return nil
		local function WriteBits(value, bitlen)
			cache = cache + value * _pow2[cache_bitlen]
			cache_bitlen = cache_bitlen + bitlen
			total_bitlen = total_bitlen + bitlen
			-- Only bulk to buffer every 4 bytes. This is quicker.
			if cache_bitlen >= 32 then
				buffer_size = buffer_size + 1
				buffer[buffer_size] =
					_byte_to_char[cache % 256]
					.._byte_to_char[((cache-cache%256)/256 % 256)]
					.._byte_to_char[((cache-cache%65536)/65536 % 256)]
					.._byte_to_char[((cache-cache%16777216)/16777216 % 256)]
				local rshift_mask = _pow2[32 - cache_bitlen + bitlen]
				cache = (value - value%rshift_mask)/rshift_mask
				cache_bitlen = cache_bitlen - 32
			end
		end

		-- Write the entire string into the writer.
		-- @param str The string being written
		-- @return nil
		local function WriteString(str)
			for _ = 1, cache_bitlen, 8 do
				buffer_size = buffer_size + 1
				buffer[buffer_size] = string_char(cache % 256)
				cache = (cache-cache%256)/256
			end
			cache_bitlen = 0
			buffer_size = buffer_size + 1
			buffer[buffer_size] = str
			total_bitlen = total_bitlen + #str*8
		end

		-- Flush current stuffs in the writer and return it.
		-- This operation will free most of the memory.
		-- @param mode See the descrtion of the constant and the source code.
		-- @return The total number of bits stored in the writer right now.
		-- for byte boundary mode, it includes the padding bits.
		-- for output mode, it does not include padding bits.
		-- @return Return the outputs if mode is output.
		local function FlushWriter(mode)
			if mode == _FLUSH_MODE_NO_FLUSH then
				return total_bitlen
			end

			if mode == _FLUSH_MODE_OUTPUT
				or mode == _FLUSH_MODE_BYTE_BOUNDARY then
				-- Full flush, also output cache.
				-- Need to pad some bits if cache_bitlen is not multiple of 8.
				local padding_bitlen = (8 - cache_bitlen % 8) % 8

				if cache_bitlen > 0 then
					-- padding with all 1 bits, mainly because "\000" is not
					-- good to be tranmitted. I do this so "\000" is a little bit
					-- less frequent.
					cache = cache - _pow2[cache_bitlen]
						+ _pow2[cache_bitlen+padding_bitlen]
					for _ = 1, cache_bitlen, 8 do
						buffer_size = buffer_size + 1
						buffer[buffer_size] = _byte_to_char[cache % 256]
						cache = (cache-cache%256)/256
					end

					cache = 0
					cache_bitlen = 0
				end
				if mode == _FLUSH_MODE_BYTE_BOUNDARY then
					total_bitlen = total_bitlen + padding_bitlen
					return total_bitlen
				end
			end

			local flushed = table_concat(buffer)
			buffer = {}
			buffer_size = 0
			result_buffer[#result_buffer+1] = flushed

			if mode == _FLUSH_MODE_MEMORY_CLEANUP then
				return total_bitlen
			else
				return total_bitlen, table_concat(result_buffer)
			end
		end

		return WriteBits, WriteString, FlushWriter
	end

	-- Push an element into a max heap
	-- @param heap A max heap whose max element is at index 1.
	-- @param e The element to be pushed. Assume element "e" is a table
	--  and comparison is done via its first entry e[1]
	-- @param heap_size current number of elements in the heap.
	--  NOTE: There may be some garbage stored in
	--  heap[heap_size+1], heap[heap_size+2], etc..
	-- @return nil
	local function MinHeapPush(heap, e, heap_size)
		heap_size = heap_size + 1
		heap[heap_size] = e
		local value = e[1]
		local pos = heap_size
		local parent_pos = (pos-pos%2)/2

		while (parent_pos >= 1 and heap[parent_pos][1] > value) do
			local t = heap[parent_pos]
			heap[parent_pos] = e
			heap[pos] = t
			pos = parent_pos
			parent_pos = (parent_pos-parent_pos%2)/2
		end
	end

	-- Pop an element from a max heap
	-- @param heap A max heap whose max element is at index 1.
	-- @param heap_size current number of elements in the heap.
	-- @return the poped element
	-- Note: This function does not change table size of "heap" to save CPU time.
	local function MinHeapPop(heap, heap_size)
		local top = heap[1]
		local e = heap[heap_size]
		local value = e[1]
		heap[1] = e
		heap[heap_size] = top
		heap_size = heap_size - 1

		local pos = 1
		local left_child_pos = pos * 2
		local right_child_pos = left_child_pos + 1

		while (left_child_pos <= heap_size) do
			local left_child = heap[left_child_pos]
			if (right_child_pos <= heap_size
				and heap[right_child_pos][1] < left_child[1]) then
				local right_child = heap[right_child_pos]
				if right_child[1] < value then
					heap[right_child_pos] = e
					heap[pos] = right_child
					pos = right_child_pos
					left_child_pos = pos * 2
					right_child_pos = left_child_pos + 1
				else
					break
				end
			else
				if left_child[1] < value then
					heap[left_child_pos] = e
					heap[pos] = left_child
					pos = left_child_pos
					left_child_pos = pos * 2
					right_child_pos = left_child_pos + 1
				else
					break
				end
			end
		end

		return top
	end

	-- Deflate defines a special huffman tree, which is unique once the bit length
	-- of huffman code of all symbols are known.
	-- @param bitlen_count Number of symbols with a specific bitlen
	-- @param symbol_bitlen The bit length of a symbol
	-- @param max_symbol The max symbol among all symbols,
	--		which is (number of symbols - 1)
	-- @param max_bitlen The max huffman bit length among all symbols.
	-- @return The huffman code of all symbols.
	local function GetHuffmanCodeFromBitlen(bitlen_counts, symbol_bitlens
		, max_symbol, max_bitlen)
		local huffman_code = 0
		local next_codes = {}
		local symbol_huffman_codes = {}
		for bitlen = 1, max_bitlen do
			huffman_code = (huffman_code+(bitlen_counts[bitlen-1] or 0))*2
			next_codes[bitlen] = huffman_code
		end
		for symbol = 0, max_symbol do
			local bitlen = symbol_bitlens[symbol]
			if bitlen then
				huffman_code = next_codes[bitlen]
				next_codes[bitlen] = huffman_code + 1

				-- Reverse the bits of huffman code,
				-- because most signifant bits of huffman code
				-- is stored first into the compressed data.
				-- @see RFC1951 Page5 Section 3.1.1
				if bitlen <= 9 then -- Have cached reverse for small bitlen.
					symbol_huffman_codes[symbol] =
						_reverse_bits_tbl[bitlen][huffman_code]
				else
					local reverse = 0
					for _ = 1, bitlen do
						reverse = reverse - reverse%2
							+ (((reverse%2==1)
								or (huffman_code % 2) == 1) and 1 or 0)
						huffman_code = (huffman_code-huffman_code%2)/2
						reverse = reverse*2
					end
					symbol_huffman_codes[symbol] = (reverse-reverse%2)/2
				end
			end
		end
		return symbol_huffman_codes
	end

	-- A helper function to sort heap elements
	-- a[1], b[1] is the huffman frequency
	-- a[2], b[2] is the symbol value.
	local function SortByFirstThenSecond(a, b)
		return a[1] < b[1] or
			(a[1] == b[1] and a[2] < b[2])
	end

	-- Calculate the huffman bit length and huffman code.
	-- @param symbol_count: A table whose table key is the symbol, and table value
	--		is the symbol frenquency (nil means 0 frequency).
	-- @param max_bitlen: See description of return value.
	-- @param max_symbol: The maximum symbol
	-- @return a table whose key is the symbol, and the value is the huffman bit
	--		bit length. We guarantee that all bit length <= max_bitlen.
	--		For 0<=symbol<=max_symbol, table value could be nil if the frequency
	--		of the symbol is 0 or nil.
	-- @return a table whose key is the symbol, and the value is the huffman code.
	-- @return a number indicating the maximum symbol whose bitlen is not 0.
	local function GetHuffmanBitlenAndCode(symbol_counts, max_bitlen, max_symbol)
		local heap_size
		local max_non_zero_bitlen_symbol = -1
		local leafs = {}
		local heap = {}
		local symbol_bitlens = {}
		local symbol_codes = {}
		local bitlen_counts = {}

	--[[
		tree[1]: weight, temporarily used as parent and bitLengths
		tree[2]: symbol
		tree[3]: left child
		tree[4]: right child
	--]]
		local number_unique_symbols = 0
		for symbol, count in pairs(symbol_counts) do
			number_unique_symbols = number_unique_symbols + 1
			leafs[number_unique_symbols] = {count, symbol}
		end

		if (number_unique_symbols == 0) then
			-- no code.
			return {}, {}, -1
		elseif (number_unique_symbols == 1) then
			-- Only one code. In this case, its huffman code
			-- needs to be assigned as 0, and bit length is 1.
			-- This is the only case that the return result
			-- represents an imcomplete huffman tree.
			local symbol = leafs[1][2]
			symbol_bitlens[symbol] = 1
			symbol_codes[symbol] = 0
			return symbol_bitlens, symbol_codes, symbol
		else
			table_sort(leafs, SortByFirstThenSecond)
			heap_size = number_unique_symbols
			for i = 1, heap_size do
				heap[i] = leafs[i]
			end

			while (heap_size > 1) do
				-- Note: pop does not change table size of heap
				local leftChild = MinHeapPop(heap, heap_size)
				heap_size = heap_size - 1
				local rightChild = MinHeapPop(heap, heap_size)
				heap_size = heap_size - 1
				local newNode =
					{leftChild[1]+rightChild[1], -1, leftChild, rightChild}
				MinHeapPush(heap, newNode, heap_size)
				heap_size = heap_size + 1
			end

			-- Number of leafs whose bit length is greater than max_len.
			local number_bitlen_overflow = 0

			-- Calculate bit length of all nodes
			local fifo = {heap[1], 0, 0, 0} -- preallocate some spaces.
			local fifo_size = 1
			local index = 1
			heap[1][1] = 0
			while (index <= fifo_size) do -- Breath first search
				local e = fifo[index]
				local bitlen = e[1]
				local symbol = e[2]
				local left_child = e[3]
				local right_child = e[4]
				if left_child then
					fifo_size = fifo_size + 1
					fifo[fifo_size] = left_child
					left_child[1] = bitlen + 1
				end
				if right_child then
					fifo_size = fifo_size + 1
					fifo[fifo_size] = right_child
					right_child[1] = bitlen + 1
				end
				index = index + 1

				if (bitlen > max_bitlen) then
					number_bitlen_overflow = number_bitlen_overflow + 1
					bitlen = max_bitlen
				end
				if symbol >= 0 then
					symbol_bitlens[symbol] = bitlen
					max_non_zero_bitlen_symbol =
						(symbol > max_non_zero_bitlen_symbol)
						and symbol or max_non_zero_bitlen_symbol
					bitlen_counts[bitlen] = (bitlen_counts[bitlen] or 0) + 1
				end
			end

			-- Resolve bit length overflow
			-- @see ZLib/trees.c:gen_bitlen(s, desc), for reference
			if (number_bitlen_overflow > 0) then
				repeat
					local bitlen = max_bitlen - 1
					while ((bitlen_counts[bitlen] or 0) == 0) do
						bitlen = bitlen - 1
					end
					-- move one leaf down the tree
					bitlen_counts[bitlen] = bitlen_counts[bitlen] - 1
					-- move one overflow item as its brother
					bitlen_counts[bitlen+1] = (bitlen_counts[bitlen+1] or 0) + 2
					bitlen_counts[max_bitlen] = bitlen_counts[max_bitlen] - 1
					number_bitlen_overflow = number_bitlen_overflow - 2
				until (number_bitlen_overflow <= 0)

				index = 1
				for bitlen = max_bitlen, 1, -1 do
					local n = bitlen_counts[bitlen] or 0
					while (n > 0) do
						local symbol = leafs[index][2]
						symbol_bitlens[symbol] = bitlen
						n = n - 1
						index = index + 1
					end
				end
			end

			symbol_codes = GetHuffmanCodeFromBitlen(bitlen_counts, symbol_bitlens,
				max_symbol, max_bitlen)
			return symbol_bitlens, symbol_codes, max_non_zero_bitlen_symbol
		end
	end

	-- Calculate the first huffman header in the dynamic huffman block
	-- @see RFC1951 Page 12
	-- @param lcode_bitlen: The huffman bit length of literal/LZ77_length.
	-- @param max_non_zero_bitlen_lcode: The maximum literal/LZ77_length symbol
	--		whose huffman bit length is not zero.
	-- @param dcode_bitlen: The huffman bit length of LZ77 distance.
	-- @param max_non_zero_bitlen_dcode: The maximum LZ77 distance symbol
	--		whose huffman bit length is not zero.
	-- @return The run length encoded codes.
	-- @return The extra bits. One entry for each rle code that needs extra bits.
	--		(code == 16 or 17 or 18).
	-- @return The count of appearance of each rle codes.
	local function RunLengthEncodeHuffmanBitlen(
		lcode_bitlens,
		max_non_zero_bitlen_lcode,
		dcode_bitlens,
		max_non_zero_bitlen_dcode)
		local rle_code_tblsize = 0
		local rle_codes = {}
		local rle_code_counts = {}
		local rle_extra_bits_tblsize = 0
		local rle_extra_bits = {}
		local prev = nil
		local count = 0

		-- If there is no distance code, assume one distance code of bit length 0.
		-- RFC1951: One distance code of zero bits means that
		-- there are no distance codes used at all (the data is all literals).
		max_non_zero_bitlen_dcode = (max_non_zero_bitlen_dcode < 0)
			and 0 or max_non_zero_bitlen_dcode
		local max_code = max_non_zero_bitlen_lcode+max_non_zero_bitlen_dcode+1

		for code = 0, max_code+1 do
			local len = (code <= max_non_zero_bitlen_lcode)
				and (lcode_bitlens[code] or 0)
				or ((code <= max_code)
					and (dcode_bitlens[code-max_non_zero_bitlen_lcode-1] or 0) or nil)
			if len == prev then
				count = count + 1
				if len ~= 0 and count == 6 then
					rle_code_tblsize = rle_code_tblsize + 1
					rle_codes[rle_code_tblsize] = 16
					rle_extra_bits_tblsize = rle_extra_bits_tblsize + 1
					rle_extra_bits[rle_extra_bits_tblsize] = 3
					rle_code_counts[16] = (rle_code_counts[16] or 0) + 1
					count = 0
				elseif len == 0 and count == 138 then
					rle_code_tblsize = rle_code_tblsize + 1
					rle_codes[rle_code_tblsize] = 18
					rle_extra_bits_tblsize = rle_extra_bits_tblsize + 1
					rle_extra_bits[rle_extra_bits_tblsize] = 127
					rle_code_counts[18] = (rle_code_counts[18] or 0) + 1
					count = 0
				end
			else
				if count == 1 then
					rle_code_tblsize = rle_code_tblsize + 1
					rle_codes[rle_code_tblsize] = prev
					rle_code_counts[prev] = (rle_code_counts[prev] or 0) + 1
				elseif count == 2 then
					rle_code_tblsize = rle_code_tblsize + 1
					rle_codes[rle_code_tblsize] = prev
					rle_code_tblsize = rle_code_tblsize + 1
					rle_codes[rle_code_tblsize] = prev
					rle_code_counts[prev] = (rle_code_counts[prev] or 0) + 2
				elseif count >= 3 then
					rle_code_tblsize = rle_code_tblsize + 1
					local rleCode = (prev ~= 0) and 16 or (count <= 10 and 17 or 18)
					rle_codes[rle_code_tblsize] = rleCode
					rle_code_counts[rleCode] = (rle_code_counts[rleCode] or 0) + 1
					rle_extra_bits_tblsize = rle_extra_bits_tblsize + 1
					rle_extra_bits[rle_extra_bits_tblsize] =
						(count <= 10) and (count - 3) or (count - 11)
				end

				prev = len
				if len and len ~= 0 then
					rle_code_tblsize = rle_code_tblsize + 1
					rle_codes[rle_code_tblsize] = len
					rle_code_counts[len] = (rle_code_counts[len] or 0) + 1
					count = 0
				else
					count = 1
				end
			end
		end

		return rle_codes, rle_extra_bits, rle_code_counts
	end

	-- Load the string into a table, in order to speed up LZ77.
	-- Loop unrolled 16 times to speed this function up.
	-- @param str The string to be loaded.
	-- @param t The load destination
	-- @param start str[index] will be the first character to be loaded.
	-- @param end str[index] will be the last character to be loaded
	-- @param offset str[index] will be loaded into t[index-offset]
	-- @return t
	local function LoadStringToTable(str, t, start, stop, offset)
		local i = start - offset
		while i <= stop - 15 - offset do
			t[i], t[i+1], t[i+2], t[i+3], t[i+4], t[i+5], t[i+6], t[i+7], t[i+8],
			t[i+9], t[i+10], t[i+11], t[i+12], t[i+13], t[i+14], t[i+15] =
				string_byte(str, i + offset, i + 15 + offset)
			i = i + 16
		end
		while (i <= stop - offset) do
			t[i] = string_byte(str, i + offset, i + offset)
			i = i + 1
		end
		return t
	end

	-- Do LZ77 process. This function uses the majority of the CPU time.
	-- @see zlib/deflate.c:deflate_fast(), zlib/deflate.c:deflate_slow()
	-- @see https://github.com/madler/zlib/blob/master/doc/algorithm.txt
	-- This function uses the algorithms used above. You should read the
	-- algorithm.txt above to understand what is the hash function and the
	-- lazy evaluation.
	--
	-- The special optimization used here is hash functions used here.
	-- The hash function is just the multiplication of the three consective
	-- characters. So if the hash matches, it guarantees 3 characters are matched.
	-- This optimization can be implemented because Lua table is a hash table.
	--
	-- @param level integer that describes compression level.
	-- @param string_table table that stores the value of string to be compressed.
	--			The index of this table starts from 1.
	--			The caller needs to make sure all values needed by this function
	--			are loaded.
	--			Assume "str" is the origin input string into the compressor
	--			str[block_start]..str[block_end+3] needs to be loaded into
	--			string_table[block_start-offset]..string_table[block_end-offset]
	--			If dictionary is presented, the last 258 bytes of the dictionary
	--			needs to be loaded into sing_table[-257..0]
	--			(See more in the description of offset.)
	-- @param hash_tables. The table key is the hash value (0<=hash<=16777216=256^3)
	--			The table value is an array0 that stores the indexes of the
	--			input data string to be compressed, such that
	--			hash == str[index]*str[index+1]*str[index+2]
	--			Indexes are ordered in this array.
	-- @param block_start The indexes of the input data string to be compressed.
	--				that starts the LZ77 block.
	-- @param block_end The indexes of the input data string to be compressed.
	--				that stores the LZ77 block.
	-- @param offset str[index] is stored in string_table[index-offset],
	--			This offset is mainly an optimization to limit the index
	--			of string_table, so lua can access this table quicker.
	-- @param dictionary See LibDeflate:CreateDictionary
	-- @return literal/LZ77_length deflate codes.
	-- @return the extra bits of literal/LZ77_length deflate codes.
	-- @return the count of each literal/LZ77 deflate code.
	-- @return LZ77 distance deflate codes.
	-- @return the extra bits of LZ77 distance deflate codes.
	-- @return the count of each LZ77 distance deflate code.
	local function GetBlockLZ77Result(level, string_table, hash_tables, block_start,
		block_end, offset, dictionary)
		local config = _compression_level_configs[level]
		local config_use_lazy
		, config_good_prev_length
		, config_max_lazy_match
		, config_nice_length
		, config_max_hash_chain =
			config[1], config[2], config[3], config[4], config[5]

		local config_max_insert_length = (not config_use_lazy)
			and config_max_lazy_match or 2147483646
		local config_good_hash_chain =
			(config_max_hash_chain-config_max_hash_chain%4/4)

		local hash

		local dict_hash_tables
		local dict_string_table
		local dict_string_len = 0

		if dictionary then
			dict_hash_tables = dictionary.hash_tables
			dict_string_table = dictionary.string_table
			dict_string_len = dictionary.strlen
			assert(block_start == 1)
			if block_end >= block_start and dict_string_len >= 2 then
				hash = dict_string_table[dict_string_len-1]*65536
					+ dict_string_table[dict_string_len]*256 + string_table[1]
				local t = hash_tables[hash]
				if not t then t = {}; hash_tables[hash] = t end
				t[#t+1] = -1
			end
			if block_end >= block_start+1 and dict_string_len >= 1 then
				hash = dict_string_table[dict_string_len]*65536
					+ string_table[1]*256 + string_table[2]
				local t = hash_tables[hash]
				if not t then t = {}; hash_tables[hash] = t end
				t[#t+1] = 0
			end
		end

		local dict_string_len_plus3 = dict_string_len + 3

		hash = (string_table[block_start-offset] or 0)*256
			+ (string_table[block_start+1-offset] or 0)

		local lcodes = {}
		local lcode_tblsize = 0
		local lcodes_counts = {}
		local dcodes = {}
		local dcodes_tblsize = 0
		local dcodes_counts = {}

		local lextra_bits = {}
		local lextra_bits_tblsize = 0
		local dextra_bits = {}
		local dextra_bits_tblsize = 0

		local match_available = false
		local prev_len
		local prev_dist
		local cur_len = 0
		local cur_dist = 0

		local index = block_start
		local index_end = block_end + (config_use_lazy and 1 or 0)

		-- the zlib source code writes separate code for lazy evaluation and
		-- not lazy evaluation, which is easier to understand.
		-- I put them together, so it is a bit harder to understand.
		-- because I think this is easier for me to maintain it.
		while (index <= index_end) do
			local string_table_index = index - offset
			local offset_minus_three = offset - 3
			prev_len = cur_len
			prev_dist = cur_dist
			cur_len = 0

			hash = (hash*256+(string_table[string_table_index+2] or 0))%16777216

			local chain_index
			local cur_chain
			local hash_chain = hash_tables[hash]
			local chain_old_size
			if not hash_chain then
				chain_old_size = 0
				hash_chain = {}
				hash_tables[hash] = hash_chain
				if dict_hash_tables then
					cur_chain = dict_hash_tables[hash]
					chain_index = cur_chain and #cur_chain or 0
				else
					chain_index = 0
				end
			else
				chain_old_size = #hash_chain
				cur_chain = hash_chain
				chain_index = chain_old_size
			end

			if index <= block_end then
				hash_chain[chain_old_size+1] = index
			end

			if (chain_index > 0 and index + 2 <= block_end
				and (not config_use_lazy or prev_len < config_max_lazy_match)) then

				local depth =
					(config_use_lazy and prev_len >= config_good_prev_length)
					and config_good_hash_chain or config_max_hash_chain

				local max_len_minus_one = block_end - index
				max_len_minus_one = (max_len_minus_one >= 257) and 257 or max_len_minus_one
				max_len_minus_one = max_len_minus_one + string_table_index
				local string_table_index_plus_three = string_table_index + 3

				while chain_index >= 1 and depth > 0 do
					local prev = cur_chain[chain_index]

					if index - prev > 32768 then
						break
					end
					if prev < index then
						local sj = string_table_index_plus_three

						if prev >= -257 then
							local pj = prev - offset_minus_three
							while (sj <= max_len_minus_one
								and string_table[pj]
								== string_table[sj]) do
								sj = sj + 1
								pj = pj + 1
							end
						else
							local pj = dict_string_len_plus3 + prev
							while (sj <= max_len_minus_one
								and dict_string_table[pj]
								== string_table[sj]) do
								sj = sj + 1
								pj = pj + 1
							end
						end
						local j = sj - string_table_index
						if j > cur_len then
							cur_len = j
							cur_dist = index - prev
						end
						if cur_len >= config_nice_length then
							break
						end
					end

					chain_index = chain_index - 1
					depth = depth - 1
					if chain_index == 0 and prev > 0 and dict_hash_tables then
						cur_chain = dict_hash_tables[hash]
						chain_index = cur_chain and #cur_chain or 0
					end
				end
			end

			if not config_use_lazy then
				prev_len, prev_dist = cur_len, cur_dist
			end
			if ((not config_use_lazy or match_available)
				and (prev_len > 3 or (prev_len == 3 and prev_dist < 4096))
				and cur_len <= prev_len )then
				local code = _length_to_deflate_code[prev_len]
				local length_extra_bits_bitlen =
					_length_to_deflate_extra_bitlen[prev_len]
				local dist_code, dist_extra_bits_bitlen, dist_extra_bits
				if prev_dist <= 256 then -- have cached code for small distance.
					dist_code = _dist256_to_deflate_code[prev_dist]
					dist_extra_bits = _dist256_to_deflate_extra_bits[prev_dist]
					dist_extra_bits_bitlen =
						_dist256_to_deflate_extra_bitlen[prev_dist]
				else
					dist_code = 16
					dist_extra_bits_bitlen = 7
					local a = 384
					local b = 512

					while true do
						if prev_dist <= a then
							dist_extra_bits = (prev_dist-(b/2)-1) % (b/4)
							break
						elseif prev_dist <= b then
							dist_extra_bits = (prev_dist-(b/2)-1) % (b/4)
							dist_code = dist_code + 1
							break
						else
							dist_code = dist_code + 2
							dist_extra_bits_bitlen = dist_extra_bits_bitlen + 1
							a = a*2
							b = b*2
						end
					end
				end
				lcode_tblsize = lcode_tblsize + 1
				lcodes[lcode_tblsize] = code
				lcodes_counts[code] = (lcodes_counts[code] or 0) + 1

				dcodes_tblsize = dcodes_tblsize + 1
				dcodes[dcodes_tblsize] = dist_code
				dcodes_counts[dist_code] = (dcodes_counts[dist_code] or 0) + 1

				if length_extra_bits_bitlen > 0 then
					local lenExtraBits = _length_to_deflate_extra_bits[prev_len]
					lextra_bits_tblsize = lextra_bits_tblsize + 1
					lextra_bits[lextra_bits_tblsize] = lenExtraBits
				end
				if dist_extra_bits_bitlen > 0 then
					dextra_bits_tblsize = dextra_bits_tblsize + 1
					dextra_bits[dextra_bits_tblsize] = dist_extra_bits
				end

				for i=index+1, index+prev_len-(config_use_lazy and 2 or 1) do
					hash = (hash*256+(string_table[i-offset+2] or 0))%16777216
					if prev_len <= config_max_insert_length then
						hash_chain = hash_tables[hash]
						if not hash_chain then
							hash_chain = {}
							hash_tables[hash] = hash_chain
						end
						hash_chain[#hash_chain+1] = i
					end
				end
				index = index + prev_len - (config_use_lazy and 1 or 0)
				match_available = false
			elseif (not config_use_lazy) or match_available then
				local code = string_table[config_use_lazy
					and (string_table_index-1) or string_table_index]
				lcode_tblsize = lcode_tblsize + 1
				lcodes[lcode_tblsize] = code
				lcodes_counts[code] = (lcodes_counts[code] or 0) + 1
				index = index + 1
			else
				match_available = true
				index = index + 1
			end
		end

		-- Write "end of block" symbol
		lcode_tblsize = lcode_tblsize + 1
		lcodes[lcode_tblsize] = 256
		lcodes_counts[256] = (lcodes_counts[256] or 0) + 1

		return lcodes, lextra_bits, lcodes_counts, dcodes, dextra_bits
		, dcodes_counts
	end

	-- Get the header data of dynamic block.
	-- @param lcodes_count The count of each literal/LZ77_length codes.
	-- @param dcodes_count The count of each Lz77 distance codes.
	-- @return a lots of stuffs.
	-- @see RFC1951 Page 12
	local function GetBlockDynamicHuffmanHeader(lcodes_counts, dcodes_counts)
		local lcodes_huffman_bitlens, lcodes_huffman_codes
		, max_non_zero_bitlen_lcode =
			GetHuffmanBitlenAndCode(lcodes_counts, 15, 285)
		local dcodes_huffman_bitlens, dcodes_huffman_codes
		, max_non_zero_bitlen_dcode =
			GetHuffmanBitlenAndCode(dcodes_counts, 15, 29)

		local rle_deflate_codes, rle_extra_bits, rle_codes_counts =
			RunLengthEncodeHuffmanBitlen(lcodes_huffman_bitlens
				,max_non_zero_bitlen_lcode, dcodes_huffman_bitlens
				, max_non_zero_bitlen_dcode)

		local rle_codes_huffman_bitlens, rle_codes_huffman_codes =
			GetHuffmanBitlenAndCode(rle_codes_counts, 7, 18)

		local HCLEN = 0
		for i = 1, 19 do
			local symbol = _rle_codes_huffman_bitlen_order[i]
			local length = rle_codes_huffman_bitlens[symbol] or 0
			if length ~= 0 then
				HCLEN = i
			end
		end

		HCLEN = HCLEN - 4
		local HLIT = max_non_zero_bitlen_lcode + 1 - 257
		local HDIST = max_non_zero_bitlen_dcode + 1 - 1
		if HDIST < 0 then HDIST = 0 end

		return HLIT, HDIST, HCLEN, rle_codes_huffman_bitlens
		, rle_codes_huffman_codes, rle_deflate_codes, rle_extra_bits
		, lcodes_huffman_bitlens, lcodes_huffman_codes
		, dcodes_huffman_bitlens, dcodes_huffman_codes
	end

	-- Get the size of dynamic block without writing any bits into the writer.
	-- @param ... Read the source code of GetBlockDynamicHuffmanHeader()
	-- @return the bit length of the dynamic block
	local function GetDynamicHuffmanBlockSize(lcodes, dcodes, HCLEN
		, rle_codes_huffman_bitlens, rle_deflate_codes
		, lcodes_huffman_bitlens, dcodes_huffman_bitlens)

		local block_bitlen = 17 -- 1+2+5+5+4
		block_bitlen = block_bitlen + (HCLEN+4)*3

		for i = 1, #rle_deflate_codes do
			local code = rle_deflate_codes[i]
			block_bitlen = block_bitlen + rle_codes_huffman_bitlens[code]
			if code >= 16 then
				block_bitlen = block_bitlen +
					((code == 16) and 2 or (code == 17 and 3 or 7))
			end
		end

		local length_code_count = 0
		for i = 1, #lcodes do
			local code = lcodes[i]
			local huffman_bitlen = lcodes_huffman_bitlens[code]
			block_bitlen = block_bitlen + huffman_bitlen
			if code > 256 then -- Length code
				length_code_count = length_code_count + 1
				if code > 264 and code < 285 then -- Length code with extra bits
					local extra_bits_bitlen =
						_literal_deflate_code_to_extra_bitlen[code-256]
					block_bitlen = block_bitlen + extra_bits_bitlen
				end
				local dist_code = dcodes[length_code_count]
				local dist_huffman_bitlen = dcodes_huffman_bitlens[dist_code]
				block_bitlen = block_bitlen + dist_huffman_bitlen

				if dist_code > 3 then -- dist code with extra bits
					local dist_extra_bits_bitlen = (dist_code-dist_code%2)/2 - 1
					block_bitlen = block_bitlen + dist_extra_bits_bitlen
				end
			end
		end
		return block_bitlen
	end

	-- Write dynamic block.
	-- @param ... Read the source code of GetBlockDynamicHuffmanHeader()
	local function CompressDynamicHuffmanBlock(WriteBits, is_last_block
		, lcodes, lextra_bits, dcodes, dextra_bits, HLIT, HDIST, HCLEN
		, rle_codes_huffman_bitlens, rle_codes_huffman_codes
		, rle_deflate_codes, rle_extra_bits
		, lcodes_huffman_bitlens, lcodes_huffman_codes
		, dcodes_huffman_bitlens, dcodes_huffman_codes)

		WriteBits(is_last_block and 1 or 0, 1) -- Last block identifier
		WriteBits(2, 2) -- Dynamic Huffman block identifier

		WriteBits(HLIT, 5)
		WriteBits(HDIST, 5)
		WriteBits(HCLEN, 4)

		for i = 1, HCLEN+4 do
			local symbol = _rle_codes_huffman_bitlen_order[i]
			local length = rle_codes_huffman_bitlens[symbol] or 0
			WriteBits(length, 3)
		end

		local rleExtraBitsIndex = 1
		for i=1, #rle_deflate_codes do
			local code = rle_deflate_codes[i]
			WriteBits(rle_codes_huffman_codes[code]
				, rle_codes_huffman_bitlens[code])
			if code >= 16 then
				local extraBits = rle_extra_bits[rleExtraBitsIndex]
				WriteBits(extraBits, (code == 16) and 2 or (code == 17 and 3 or 7))
				rleExtraBitsIndex = rleExtraBitsIndex + 1
			end
		end

		local length_code_count = 0
		local length_code_with_extra_count = 0
		local dist_code_with_extra_count = 0

		for i=1, #lcodes do
			local deflate_codee = lcodes[i]
			local huffman_code = lcodes_huffman_codes[deflate_codee]
			local huffman_bitlen = lcodes_huffman_bitlens[deflate_codee]
			WriteBits(huffman_code, huffman_bitlen)
			if deflate_codee > 256 then -- Length code
				length_code_count = length_code_count + 1
				if deflate_codee > 264 and deflate_codee < 285 then
					-- Length code with extra bits
					length_code_with_extra_count = length_code_with_extra_count + 1
					local extra_bits = lextra_bits[length_code_with_extra_count]
					local extra_bits_bitlen =
						_literal_deflate_code_to_extra_bitlen[deflate_codee-256]
					WriteBits(extra_bits, extra_bits_bitlen)
				end
				-- Write distance code
				local dist_deflate_code = dcodes[length_code_count]
				local dist_huffman_code = dcodes_huffman_codes[dist_deflate_code]
				local dist_huffman_bitlen =
					dcodes_huffman_bitlens[dist_deflate_code]
				WriteBits(dist_huffman_code, dist_huffman_bitlen)

				if dist_deflate_code > 3 then -- dist code with extra bits
					dist_code_with_extra_count = dist_code_with_extra_count + 1
					local dist_extra_bits = dextra_bits[dist_code_with_extra_count]
					local dist_extra_bits_bitlen =
						(dist_deflate_code-dist_deflate_code%2)/2 - 1
					WriteBits(dist_extra_bits, dist_extra_bits_bitlen)
				end
			end
		end
	end

	-- Get the size of fixed block without writing any bits into the writer.
	-- @param lcodes literal/LZ77_length deflate codes
	-- @param decodes LZ77 distance deflate codes
	-- @return the bit length of the fixed block
	local function GetFixedHuffmanBlockSize(lcodes, dcodes)
		local block_bitlen = 3
		local length_code_count = 0
		for i=1, #lcodes do
			local code = lcodes[i]
			local huffman_bitlen = _fix_block_literal_huffman_bitlen[code]
			block_bitlen = block_bitlen + huffman_bitlen
			if code > 256 then -- Length code
				length_code_count = length_code_count + 1
				if code > 264 and code < 285 then -- Length code with extra bits
					local extra_bits_bitlen =
						_literal_deflate_code_to_extra_bitlen[code-256]
					block_bitlen = block_bitlen + extra_bits_bitlen
				end
				local dist_code = dcodes[length_code_count]
				block_bitlen = block_bitlen + 5

				if dist_code > 3 then -- dist code with extra bits
					local dist_extra_bits_bitlen =
						(dist_code-dist_code%2)/2 - 1
					block_bitlen = block_bitlen + dist_extra_bits_bitlen
				end
			end
		end
		return block_bitlen
	end

	-- Write fixed block.
	-- @param lcodes literal/LZ77_length deflate codes
	-- @param decodes LZ77 distance deflate codes
	local function CompressFixedHuffmanBlock(WriteBits, is_last_block,
		lcodes, lextra_bits, dcodes, dextra_bits)
		WriteBits(is_last_block and 1 or 0, 1) -- Last block identifier
		WriteBits(1, 2) -- Fixed Huffman block identifier
		local length_code_count = 0
		local length_code_with_extra_count = 0
		local dist_code_with_extra_count = 0
		for i=1, #lcodes do
			local deflate_code = lcodes[i]
			local huffman_code = _fix_block_literal_huffman_code[deflate_code]
			local huffman_bitlen = _fix_block_literal_huffman_bitlen[deflate_code]
			WriteBits(huffman_code, huffman_bitlen)
			if deflate_code > 256 then -- Length code
				length_code_count = length_code_count + 1
				if deflate_code > 264 and deflate_code < 285 then
					-- Length code with extra bits
					length_code_with_extra_count = length_code_with_extra_count + 1
					local extra_bits = lextra_bits[length_code_with_extra_count]
					local extra_bits_bitlen =
						_literal_deflate_code_to_extra_bitlen[deflate_code-256]
					WriteBits(extra_bits, extra_bits_bitlen)
				end
				-- Write distance code
				local dist_code = dcodes[length_code_count]
				local dist_huffman_code = _fix_block_dist_huffman_code[dist_code]
				WriteBits(dist_huffman_code, 5)

				if dist_code > 3 then -- dist code with extra bits
					dist_code_with_extra_count = dist_code_with_extra_count + 1
					local dist_extra_bits = dextra_bits[dist_code_with_extra_count]
					local dist_extra_bits_bitlen = (dist_code-dist_code%2)/2 - 1
					WriteBits(dist_extra_bits, dist_extra_bits_bitlen)
				end
			end
		end
	end

	-- Get the size of store block without writing any bits into the writer.
	-- @param block_start The start index of the origin input string
	-- @param block_end The end index of the origin input string
	-- @param Total bit lens had been written into the compressed result before,
	-- because store block needs to shift to byte boundary.
	-- @return the bit length of the fixed block
	local function GetStoreBlockSize(block_start, block_end, total_bitlen)
		assert(block_end-block_start+1 <= 65535)
		local block_bitlen = 3
		total_bitlen = total_bitlen + 3
		local padding_bitlen = (8-total_bitlen%8)%8
		block_bitlen = block_bitlen + padding_bitlen
		block_bitlen = block_bitlen + 32
		block_bitlen = block_bitlen + (block_end - block_start + 1) * 8
		return block_bitlen
	end

	-- Write the store block.
	-- @param ... lots of stuffs
	-- @return nil
	local function CompressStoreBlock(WriteBits, WriteString, is_last_block, str
		, block_start, block_end, total_bitlen)
		assert(block_end-block_start+1 <= 65535)
		WriteBits(is_last_block and 1 or 0, 1) -- Last block identifer.
		WriteBits(0, 2) -- Store block identifier.
		total_bitlen = total_bitlen + 3
		local padding_bitlen = (8-total_bitlen%8)%8
		if padding_bitlen > 0 then
			WriteBits(_pow2[padding_bitlen]-1, padding_bitlen)
		end
		local size = block_end - block_start + 1
		WriteBits(size, 16)

		-- Write size's one's complement
		local comp = (255 - size % 256) + (255 - (size-size%256)/256)*256
		WriteBits(comp, 16)

		WriteString(str:sub(block_start, block_end))
	end

	-- Do the deflate
	-- Currently using a simple way to determine the block size
	-- (This is why the compression ratio is little bit worse than zlib when
	-- the input size is very large
	-- The first block is 64KB, the following block is 32KB.
	-- After each block, there is a memory cleanup operation.
	-- This is not a fast operation, but it is needed to save memory usage, so
	-- the memory usage does not grow unboundly. If the data size is less than
	-- 64KB, then memory cleanup won't happen.
	-- This function determines whether to use store/fixed/dynamic blocks by
	-- calculating the block size of each block type and chooses the smallest one.
	local function Deflate(configs, WriteBits, WriteString, FlushWriter, str
		, dictionary)
		local string_table = {}
		local hash_tables = {}
		local is_last_block = nil
		local block_start
		local block_end
		local bitlen_written
		local total_bitlen = FlushWriter(_FLUSH_MODE_NO_FLUSH)
		local strlen = #str
		local offset

		local level
		local strategy
		if configs then
			if configs.level then
				level = configs.level
			end
			if configs.strategy then
				strategy = configs.strategy
			end
		end

		if not level then
			if strlen < 2048 then
				level = 7
			elseif strlen > 65536 then
				level = 3
			else
				level = 5
			end
		end

		while not is_last_block do
			if not block_start then
				block_start = 1
				block_end = 64*1024 - 1
				offset = 0
			else
				block_start = block_end + 1
				block_end = block_end + 32*1024
				offset = block_start - 32*1024 - 1
			end

			if block_end >= strlen then
				block_end = strlen
				is_last_block = true
			else
				is_last_block = false
			end

			local lcodes, lextra_bits, lcodes_counts, dcodes, dextra_bits
			, dcodes_counts

			local HLIT, HDIST, HCLEN, rle_codes_huffman_bitlens
			, rle_codes_huffman_codes, rle_deflate_codes
			, rle_extra_bits, lcodes_huffman_bitlens, lcodes_huffman_codes
			, dcodes_huffman_bitlens, dcodes_huffman_codes

			local dynamic_block_bitlen
			local fixed_block_bitlen
			local store_block_bitlen

			if level ~= 0 then

				-- GetBlockLZ77 needs block_start to block_end+3 to be loaded.
				LoadStringToTable(str, string_table, block_start, block_end + 3
					, offset)
				if block_start == 1 and dictionary then
					local dict_string_table = dictionary.string_table
					local dict_strlen = dictionary.strlen
					for i=0, (-dict_strlen+1)<-257
						and -257 or (-dict_strlen+1), -1 do
						string_table[i] = dict_string_table[dict_strlen+i]
					end
				end

				if strategy == "huffman_only" then
					lcodes = {}
					LoadStringToTable(str, lcodes, block_start, block_end
						, block_start-1)
					lextra_bits = {}
					lcodes_counts = {}
					lcodes[block_end - block_start+2] = 256 -- end of block
					for i=1, block_end - block_start+2 do
						local code = lcodes[i]
						lcodes_counts[code] = (lcodes_counts[code] or 0) + 1
					end
					dcodes = {}
					dextra_bits = {}
					dcodes_counts = {}
				else
					lcodes, lextra_bits, lcodes_counts, dcodes, dextra_bits
					, dcodes_counts = GetBlockLZ77Result(level, string_table
						, hash_tables, block_start, block_end, offset, dictionary
					)
				end

				HLIT, HDIST, HCLEN, rle_codes_huffman_bitlens
				, rle_codes_huffman_codes, rle_deflate_codes
				, rle_extra_bits, lcodes_huffman_bitlens, lcodes_huffman_codes
				, dcodes_huffman_bitlens, dcodes_huffman_codes =
					GetBlockDynamicHuffmanHeader(lcodes_counts, dcodes_counts)
				dynamic_block_bitlen = GetDynamicHuffmanBlockSize(
					lcodes, dcodes, HCLEN, rle_codes_huffman_bitlens
					, rle_deflate_codes, lcodes_huffman_bitlens
					, dcodes_huffman_bitlens)
				fixed_block_bitlen = GetFixedHuffmanBlockSize(lcodes, dcodes)
			end

			store_block_bitlen = GetStoreBlockSize(block_start, block_end
				, total_bitlen)

			local min_bitlen = store_block_bitlen
			min_bitlen = (fixed_block_bitlen and fixed_block_bitlen < min_bitlen)
				and fixed_block_bitlen or min_bitlen
			min_bitlen = (dynamic_block_bitlen
				and dynamic_block_bitlen < min_bitlen)
				and dynamic_block_bitlen or min_bitlen

			if level == 0 or (strategy ~= "fixed" and strategy ~= "dynamic" and
				store_block_bitlen == min_bitlen) then
				CompressStoreBlock(WriteBits, WriteString, is_last_block
					, str, block_start, block_end, total_bitlen)
				total_bitlen = total_bitlen + store_block_bitlen
			elseif strategy ~= "dynamic" and (
				strategy == "fixed" or fixed_block_bitlen == min_bitlen) then
				CompressFixedHuffmanBlock(WriteBits, is_last_block,
					lcodes, lextra_bits, dcodes, dextra_bits)
				total_bitlen = total_bitlen + fixed_block_bitlen
			elseif strategy == "dynamic" or dynamic_block_bitlen == min_bitlen then
				CompressDynamicHuffmanBlock(WriteBits, is_last_block, lcodes
					, lextra_bits, dcodes, dextra_bits, HLIT, HDIST, HCLEN
					, rle_codes_huffman_bitlens, rle_codes_huffman_codes
					, rle_deflate_codes, rle_extra_bits
					, lcodes_huffman_bitlens, lcodes_huffman_codes
					, dcodes_huffman_bitlens, dcodes_huffman_codes)
				total_bitlen = total_bitlen + dynamic_block_bitlen
			end

			if is_last_block then
				bitlen_written = FlushWriter(_FLUSH_MODE_NO_FLUSH)
			else
				bitlen_written = FlushWriter(_FLUSH_MODE_MEMORY_CLEANUP)
			end

			assert(bitlen_written == total_bitlen)

			-- Memory clean up, so memory consumption does not always grow linearly
			-- , even if input string is > 64K.
			-- Not a very efficient operation, but this operation won't happen
			-- when the input data size is less than 64K.
			if not is_last_block then
				local j
				if dictionary and block_start == 1 then
					j = 0
					while (string_table[j]) do
						string_table[j] = nil
						j = j - 1
					end
				end
				dictionary = nil
				j = 1
				for i = block_end-32767, block_end do
					string_table[j] = string_table[i-offset]
					j = j + 1
				end

				for k, t in pairs(hash_tables) do
					local tSize = #t
					if tSize > 0 and block_end+1 - t[1] > 32768 then
						if tSize == 1 then
							hash_tables[k] = nil
						else
							local new = {}
							local newSize = 0
							for i = 2, tSize do
								j = t[i]
								if block_end+1 - j <= 32768 then
									newSize = newSize + 1
									new[newSize] = j
								end
							end
							hash_tables[k] = new
						end
					end
				end
			end
		end
	end

	--- The description to compression configuration table. <br>
	-- Any field can be nil to use its default. <br>
	-- Table with keys other than those below is an invalid table.
	-- @class table
	-- @name compression_configs
	-- @field level The compression level ranged from 0 to 9. 0 is no compression.
	-- 9 is the slowest but best compression. Use nil for default level.
	-- @field strategy The compression strategy. "fixed" to only use fixed deflate
	-- compression block. "dynamic" to only use dynamic block. "huffman_only" to
	-- do no LZ77 compression. Only do huffman compression.


	-- @see LibDeflate:CompressDeflate(str, configs)
	-- @see LibDeflate:CompressDeflateWithDict(str, dictionary, configs)
	local function CompressDeflateInternal(str, dictionary, configs)
		local WriteBits, WriteString, FlushWriter = CreateWriter()
		Deflate(configs, WriteBits, WriteString, FlushWriter, str, dictionary)
		local total_bitlen, result = FlushWriter(_FLUSH_MODE_OUTPUT)
		local padding_bitlen = (8-total_bitlen%8)%8
		return result, padding_bitlen
	end

	-- @see LibDeflate:CompressZlib
	-- @see LibDeflate:CompressZlibWithDict
	local function CompressZlibInternal(str, dictionary, configs)
		local WriteBits, WriteString, FlushWriter = CreateWriter()

		local CM = 8 -- Compression method
		local CINFO = 7 --Window Size = 32K
		local CMF = CINFO*16+CM
		WriteBits(CMF, 8)

		local FDIST = dictionary and 1 or 0
		local FLEVEL = 2 -- Default compression
		local FLG = FLEVEL*64+FDIST*32
		local FCHECK = (31-(CMF*256+FLG)%31)
		-- The FCHECK value must be such that CMF and FLG,
		-- when viewed as a 16-bit unsigned integer stored
		-- in MSB order (CMF*256 + FLG), is a multiple of 31.
		FLG = FLG + FCHECK
		WriteBits(FLG, 8)

		if FDIST == 1 then
			local adler32 = dictionary.adler32
			local byte0 = adler32 % 256
			adler32 = (adler32 - byte0) / 256
			local byte1 = adler32 % 256
			adler32 = (adler32 - byte1) / 256
			local byte2 = adler32 % 256
			adler32 = (adler32 - byte2) / 256
			local byte3 = adler32 % 256
			WriteBits(byte3, 8)
			WriteBits(byte2, 8)
			WriteBits(byte1, 8)
			WriteBits(byte0, 8)
		end

		Deflate(configs, WriteBits, WriteString, FlushWriter, str, dictionary)
		FlushWriter(_FLUSH_MODE_BYTE_BOUNDARY)

		local adler32 = LibDeflate:Adler32(str)

		-- Most significant byte first
		local byte3 = adler32%256
		adler32 = (adler32 - byte3) / 256
		local byte2 = adler32%256
		adler32 = (adler32 - byte2) / 256
		local byte1 = adler32%256
		adler32 = (adler32 - byte1) / 256
		local byte0 = adler32%256

		WriteBits(byte0, 8)
		WriteBits(byte1, 8)
		WriteBits(byte2, 8)
		WriteBits(byte3, 8)
		local total_bitlen, result = FlushWriter(_FLUSH_MODE_OUTPUT)
		local padding_bitlen = (8-total_bitlen%8)%8
		return result, padding_bitlen
	end

	--- Compress using the raw deflate format.
	-- @param str [string] The data to be compressed.
	-- @param configs [table/nil] The configuration table to control the compression
	-- . If nil, use the default configuration.
	-- @return [string] The compressed data.
	-- @return [integer] The number of bits padded at the end of output.
	-- 0 <= bits < 8  <br>
	-- This means the most significant "bits" of the last byte of the returned
	-- compressed data are padding bits and they don't affect decompression.
	-- You don't need to use this value unless you want to do some postprocessing
	-- to the compressed data.
	-- @see compression_configs
	-- @see LibDeflate:DecompressDeflate
	function LibDeflate:CompressDeflate(str, configs)
		local arg_valid, arg_err = IsValidArguments(str, false, nil, true, configs)
		if not arg_valid then
			error(("Usage: LibDeflate:CompressDeflate(str, configs): "
				..arg_err), 2)
		end
		return CompressDeflateInternal(str, nil, configs)
	end

	--- Compress using the raw deflate format with a preset dictionary.
	-- @param str [string] The data to be compressed.
	-- @param dictionary [table] The preset dictionary produced by
	-- LibDeflate:CreateDictionary
	-- @param configs [table/nil] The configuration table to control the compression
	-- . If nil, use the default configuration.
	-- @return [string] The compressed data.
	-- @return [integer] The number of bits padded at the end of output.
	-- 0 <= bits < 8  <br>
	-- This means the most significant "bits" of the last byte of the returned
	-- compressed data are padding bits and they don't affect decompression.
	-- You don't need to use this value unless you want to do some postprocessing
	-- to the compressed data.
	-- @see compression_configs
	-- @see LibDeflate:CreateDictionary
	-- @see LibDeflate:DecompressDeflateWithDict
	function LibDeflate:CompressDeflateWithDict(str, dictionary, configs)
		local arg_valid, arg_err = IsValidArguments(str, true, dictionary
			, true, configs)
		if not arg_valid then
			error(("Usage: LibDeflate:CompressDeflateWithDict"
				.."(str, dictionary, configs): "
				..arg_err), 2)
		end
		return CompressDeflateInternal(str, dictionary, configs)
	end

	--- Compress using the zlib format.
	-- @param str [string] the data to be compressed.
	-- @param configs [table/nil] The configuration table to control the compression
	-- . If nil, use the default configuration.
	-- @return [string] The compressed data.
	-- @return [integer] The number of bits padded at the end of output.
	-- Should always be 0.
	-- Zlib formatted compressed data never has padding bits at the end.
	-- @see compression_configs
	-- @see LibDeflate:DecompressZlib
	function LibDeflate:CompressZlib(str, configs)
		local arg_valid, arg_err = IsValidArguments(str, false, nil, true, configs)
		if not arg_valid then
			error(("Usage: LibDeflate:CompressZlib(str, configs): "
				..arg_err), 2)
		end
		return CompressZlibInternal(str, nil, configs)
	end

	--- Compress using the zlib format with a preset dictionary.
	-- @param str [string] the data to be compressed.
	-- @param dictionary [table] A preset dictionary produced
	-- by LibDeflate:CreateDictionary()
	-- @param configs [table/nil] The configuration table to control the compression
	-- . If nil, use the default configuration.
	-- @return [string] The compressed data.
	-- @return [integer] The number of bits padded at the end of output.
	-- Should always be 0.
	-- Zlib formatted compressed data never has padding bits at the end.
	-- @see compression_configs
	-- @see LibDeflate:CreateDictionary
	-- @see LibDeflate:DecompressZlibWithDict
	function LibDeflate:CompressZlibWithDict(str, dictionary, configs)
		local arg_valid, arg_err = IsValidArguments(str, true, dictionary
			, true, configs)
		if not arg_valid then
			error(("Usage: LibDeflate:CompressZlibWithDict"
				.."(str, dictionary, configs): "
				..arg_err), 2)
		end
		return CompressZlibInternal(str, dictionary, configs)
	end

--[[ --------------------------------------------------------------------------
	Decompress code
--]] --------------------------------------------------------------------------

--[[
	Create a reader to easily reader stuffs as the unit of bits.
	Return values:
	1. ReadBits(bitlen)
	2. ReadBytes(bytelen, buffer, buffer_size)
	3. Decode(huffman_bitlen_count, huffman_symbol, min_bitlen)
	4. ReaderBitlenLeft()
	5. SkipToByteBoundary()
--]]
	local function CreateReader(input_string)
		local input = input_string
		local input_strlen = #input_string
		local input_next_byte_pos = 1
		local cache_bitlen = 0
		local cache = 0

		-- Read some bits.
		-- To improve speed, this function does not
		-- check if the input has been exhausted.
		-- Use ReaderBitlenLeft() < 0 to check it.
		-- @param bitlen the number of bits to read
		-- @return the data is read.
		local function ReadBits(bitlen)
			local rshift_mask = _pow2[bitlen]
			local code
			if bitlen <= cache_bitlen then
				code = cache % rshift_mask
				cache = (cache - code) / rshift_mask
				cache_bitlen = cache_bitlen - bitlen
			else -- Whether input has been exhausted is not checked.
				local lshift_mask = _pow2[cache_bitlen]
				local byte1, byte2, byte3, byte4 = string_byte(input
					, input_next_byte_pos, input_next_byte_pos+3)
				-- This requires lua number to be at least double ()
				cache = cache + ((byte1 or 0)+(byte2 or 0)*256
					+ (byte3 or 0)*65536+(byte4 or 0)*16777216)*lshift_mask
				input_next_byte_pos = input_next_byte_pos + 4
				cache_bitlen = cache_bitlen + 32 - bitlen
				code = cache % rshift_mask
				cache = (cache - code) / rshift_mask
			end
			return code
		end

		-- Read some bytes from the reader.
		-- Assume reader is on the byte boundary.
		-- @param bytelen The number of bytes to be read.
		-- @param buffer The byte read will be stored into this buffer.
		-- @param buffer_size The buffer will be modified starting from
		--	buffer[buffer_size+1], ending at buffer[buffer_size+bytelen-1]
		-- @return the new buffer_size
		local function ReadBytes(bytelen, buffer, buffer_size)
			assert(cache_bitlen % 8 == 0)

			local byte_from_cache = (cache_bitlen/8 < bytelen)
				and (cache_bitlen/8) or bytelen
			for _=1, byte_from_cache do
				local byte = cache % 256
				buffer_size = buffer_size + 1
				buffer[buffer_size] = string_char(byte)
				cache = (cache - byte) / 256
			end
			cache_bitlen = cache_bitlen - byte_from_cache*8
			bytelen = bytelen - byte_from_cache
			if (input_strlen - input_next_byte_pos - bytelen + 1) * 8
				+ cache_bitlen < 0 then
				return -1 -- out of input
			end
			for i=input_next_byte_pos, input_next_byte_pos+bytelen-1 do
				buffer_size = buffer_size + 1
				buffer[buffer_size] = string_sub(input, i, i)
			end

			input_next_byte_pos = input_next_byte_pos + bytelen
			return buffer_size
		end

		-- Decode huffman code
		-- To improve speed, this function does not check
		-- if the input has been exhausted.
		-- Use ReaderBitlenLeft() < 0 to check it.
		-- Credits for Mark Adler. This code is from puff:Decode()
		-- @see puff:Decode(...)
		-- @param huffman_bitlen_count
		-- @param huffman_symbol
		-- @param min_bitlen The minimum huffman bit length of all symbols
		-- @return The decoded deflate code.
		--	Negative value is returned if decoding fails.
		local function Decode(huffman_bitlen_counts, huffman_symbols, min_bitlen)
			local code = 0
			local first = 0
			local index = 0
			local count
			if min_bitlen > 0 then
				if cache_bitlen < 15 and input then
					local lshift_mask = _pow2[cache_bitlen]
					local byte1, byte2, byte3, byte4 =
						string_byte(input, input_next_byte_pos
							, input_next_byte_pos+3)
					-- This requires lua number to be at least double ()
					cache = cache + ((byte1 or 0)+(byte2 or 0)*256
						+(byte3 or 0)*65536+(byte4 or 0)*16777216)*lshift_mask
					input_next_byte_pos = input_next_byte_pos + 4
					cache_bitlen = cache_bitlen + 32
				end

				local rshift_mask = _pow2[min_bitlen]
				cache_bitlen = cache_bitlen - min_bitlen
				code = cache % rshift_mask
				cache = (cache - code) / rshift_mask
				-- Reverse the bits
				code = _reverse_bits_tbl[min_bitlen][code]

				count = huffman_bitlen_counts[min_bitlen]
				if code < count then
					return huffman_symbols[code]
				end
				index = count
				first = count * 2
				code = code * 2
			end

			for bitlen = min_bitlen+1, 15 do
				local bit
				bit = cache % 2
				cache = (cache - bit) / 2
				cache_bitlen = cache_bitlen - 1

				code = (bit==1) and (code + 1 - code % 2) or code
				count = huffman_bitlen_counts[bitlen] or 0
				local diff = code - first
				if diff < count then
					return huffman_symbols[index + diff]
				end
				index = index + count
				first = first + count
				first = first * 2
				code = code * 2
			end
			-- invalid literal/length or distance code
			-- in fixed or dynamic block (run out of code)
			return -10
		end

		local function ReaderBitlenLeft()
			return (input_strlen - input_next_byte_pos + 1) * 8 + cache_bitlen
		end

		local function SkipToByteBoundary()
			local skipped_bitlen = cache_bitlen%8
			local rshift_mask = _pow2[skipped_bitlen]
			cache_bitlen = cache_bitlen - skipped_bitlen
			cache = (cache - cache % rshift_mask) / rshift_mask
		end

		return ReadBits, ReadBytes, Decode, ReaderBitlenLeft, SkipToByteBoundary
	end

	-- Create a deflate state, so I can pass in less arguments to functions.
	-- @param str the whole string to be decompressed.
	-- @param dictionary The preset dictionary. nil if not provided.
	--		This dictionary should be produced by LibDeflate:CreateDictionary(str)
	-- @return The decomrpess state.
	local function CreateDecompressState(str, dictionary)
		local ReadBits, ReadBytes, Decode, ReaderBitlenLeft
		, SkipToByteBoundary = CreateReader(str)
		local state =
			{
				ReadBits = ReadBits,
				ReadBytes = ReadBytes,
				Decode = Decode,
				ReaderBitlenLeft = ReaderBitlenLeft,
				SkipToByteBoundary = SkipToByteBoundary,
				buffer_size = 0,
				buffer = {},
				result_buffer = {},
				dictionary = dictionary,
			}
		return state
	end

	-- Get the stuffs needed to decode huffman codes
	-- @see puff.c:construct(...)
	-- @param huffman_bitlen The huffman bit length of the huffman codes.
	-- @param max_symbol The maximum symbol
	-- @param max_bitlen The min huffman bit length of all codes
	-- @return zero or positive for success, negative for failure.
	-- @return The count of each huffman bit length.
	-- @return A table to convert huffman codes to deflate codes.
	-- @return The minimum huffman bit length.
	local function GetHuffmanForDecode(huffman_bitlens, max_symbol, max_bitlen)
		local huffman_bitlen_counts = {}
		local min_bitlen = max_bitlen
		for symbol = 0, max_symbol do
			local bitlen = huffman_bitlens[symbol] or 0
			min_bitlen = (bitlen > 0 and bitlen < min_bitlen)
				and bitlen or min_bitlen
			huffman_bitlen_counts[bitlen] = (huffman_bitlen_counts[bitlen] or 0)+1
		end

		if huffman_bitlen_counts[0] == max_symbol+1 then -- No Codes
			return 0, huffman_bitlen_counts, {}, 0 -- Complete, but decode will fail
		end

		local left = 1
		for len = 1, max_bitlen do
			left = left * 2
			left = left - (huffman_bitlen_counts[len] or 0)
			if left < 0 then
				return left -- Over-subscribed, return negative
			end
		end

		-- Generate offsets info symbol table for each length for sorting
		local offsets = {}
		offsets[1] = 0
		for len = 1, max_bitlen-1 do
			offsets[len + 1] = offsets[len] + (huffman_bitlen_counts[len] or 0)
		end

		local huffman_symbols = {}
		for symbol = 0, max_symbol do
			local bitlen = huffman_bitlens[symbol] or 0
			if bitlen ~= 0 then
				local offset = offsets[bitlen]
				huffman_symbols[offset] = symbol
				offsets[bitlen] = offsets[bitlen] + 1
			end
		end

		-- Return zero for complete set, positive for incomplete set.
		return left, huffman_bitlen_counts, huffman_symbols, min_bitlen
	end

	-- Decode a fixed or dynamic huffman blocks, excluding last block identifier
	-- and block type identifer.
	-- @see puff.c:codes()
	-- @param state decompression state that will be modified by this function.
	--	@see CreateDecompressState
	-- @param ... Read the source code
	-- @return 0 on success, other value on failure.
	local function DecodeUntilEndOfBlock(state, lcodes_huffman_bitlens
		, lcodes_huffman_symbols, lcodes_huffman_min_bitlen
		, dcodes_huffman_bitlens, dcodes_huffman_symbols
		, dcodes_huffman_min_bitlen)
		local buffer, buffer_size, ReadBits, Decode, ReaderBitlenLeft
		, result_buffer =
			state.buffer, state.buffer_size, state.ReadBits, state.Decode
		, state.ReaderBitlenLeft, state.result_buffer
		local dictionary = state.dictionary
		local dict_string_table
		local dict_strlen

		local buffer_end = 1
		if dictionary and not buffer[0] then
			-- If there is a dictionary, copy the last 258 bytes into
			-- the string_table to make the copy in the main loop quicker.
			-- This is done only once per decompression.
			dict_string_table = dictionary.string_table
			dict_strlen = dictionary.strlen
			buffer_end = -dict_strlen + 1
			for i=0, (-dict_strlen+1)<-257 and -257 or (-dict_strlen+1), -1 do
				buffer[i] = _byte_to_char[dict_string_table[dict_strlen+i]]
			end
		end

		repeat
			local symbol = Decode(lcodes_huffman_bitlens
				, lcodes_huffman_symbols, lcodes_huffman_min_bitlen)
			if symbol < 0 or symbol > 285 then
				-- invalid literal/length or distance code in fixed or dynamic block
				return -10
			elseif symbol < 256 then -- Literal
				buffer_size = buffer_size + 1
				buffer[buffer_size] = _byte_to_char[symbol]
			elseif symbol > 256 then -- Length code
				symbol = symbol - 256
				local bitlen = _literal_deflate_code_to_base_len[symbol]
				bitlen = (symbol >= 8)
					and (bitlen
						+ ReadBits(_literal_deflate_code_to_extra_bitlen[symbol]))
					or bitlen
				symbol = Decode(dcodes_huffman_bitlens, dcodes_huffman_symbols
					, dcodes_huffman_min_bitlen)
				if symbol < 0 or symbol > 29 then
					-- invalid literal/length or distance code in fixed or dynamic block
					return -10
				end
				local dist = _dist_deflate_code_to_base_dist[symbol]
				dist = (dist > 4) and (dist
					+ ReadBits(_dist_deflate_code_to_extra_bitlen[symbol])) or dist

				local char_buffer_index = buffer_size-dist+1
				if char_buffer_index < buffer_end then
					-- distance is too far back in fixed or dynamic block
					return -11
				end
				if char_buffer_index >= -257 then
					for _=1, bitlen do
						buffer_size = buffer_size + 1
						buffer[buffer_size] = buffer[char_buffer_index]
						char_buffer_index = char_buffer_index + 1
					end
				else
					char_buffer_index = dict_strlen + char_buffer_index
					for _=1, bitlen do
						buffer_size = buffer_size + 1
						buffer[buffer_size] =
							_byte_to_char[dict_string_table[char_buffer_index]]
						char_buffer_index = char_buffer_index + 1
					end
				end
			end

			if ReaderBitlenLeft() < 0 then
				return 2 -- available inflate data did not terminate
			end

			if buffer_size >= 65536 then
				result_buffer[#result_buffer+1] =
					table_concat(buffer, "", 1, 32768)
				for i=32769, buffer_size do
					buffer[i-32768] = buffer[i]
				end
				buffer_size = buffer_size - 32768
				buffer[buffer_size+1] = nil
				-- NOTE: buffer[32769..end] and buffer[-257..0] are not cleared.
				-- This is why "buffer_size" variable is needed.
			end
		until symbol == 256

		state.buffer_size = buffer_size

		return 0
	end

	-- Decompress a store block
	-- @param state decompression state that will be modified by this function.
	-- @return 0 if succeeds, other value if fails.
	local function DecompressStoreBlock(state)
		local buffer, buffer_size, ReadBits, ReadBytes, ReaderBitlenLeft
		, SkipToByteBoundary, result_buffer =
			state.buffer, state.buffer_size, state.ReadBits, state.ReadBytes
		, state.ReaderBitlenLeft, state.SkipToByteBoundary, state.result_buffer

		SkipToByteBoundary()
		local bytelen = ReadBits(16)
		if ReaderBitlenLeft() < 0 then
			return 2 -- available inflate data did not terminate
		end
		local bytelenComp = ReadBits(16)
		if ReaderBitlenLeft() < 0 then
			return 2 -- available inflate data did not terminate
		end

		if bytelen % 256 + bytelenComp % 256 ~= 255 then
			return -2 -- Not one's complement
		end
		if (bytelen-bytelen % 256)/256
			+ (bytelenComp-bytelenComp % 256)/256 ~= 255 then
			return -2 -- Not one's complement
		end

		-- Note that ReadBytes will skip to the next byte boundary first.
		buffer_size = ReadBytes(bytelen, buffer, buffer_size)
		if buffer_size < 0 then
			return 2 -- available inflate data did not terminate
		end

		-- memory clean up when there are enough bytes in the buffer.
		if buffer_size >= 65536 then
			result_buffer[#result_buffer+1] = table_concat(buffer, "", 1, 32768)
			for i=32769, buffer_size do
				buffer[i-32768] = buffer[i]
			end
			buffer_size = buffer_size - 32768
			buffer[buffer_size+1] = nil
		end
		state.buffer_size = buffer_size
		return 0
	end

	-- Decompress a fixed block
	-- @param state decompression state that will be modified by this function.
	-- @return 0 if succeeds other value if fails.
	local function DecompressFixBlock(state)
		return DecodeUntilEndOfBlock(state
			, _fix_block_literal_huffman_bitlen_count
			, _fix_block_literal_huffman_to_deflate_code, 7
			, _fix_block_dist_huffman_bitlen_count
			, _fix_block_dist_huffman_to_deflate_code, 5)
	end

	-- Decompress a dynamic block
	-- @param state decompression state that will be modified by this function.
	-- @return 0 if success, other value if fails.
	local function DecompressDynamicBlock(state)
		local ReadBits, Decode = state.ReadBits, state.Decode
		local nlen = ReadBits(5) + 257
		local ndist = ReadBits(5) + 1
		local ncode = ReadBits(4) + 4
		if nlen > 286 or ndist > 30 then
			-- dynamic block code description: too many length or distance codes
			return -3
		end

		local rle_codes_huffman_bitlens = {}

		for i = 1, ncode do
			rle_codes_huffman_bitlens[_rle_codes_huffman_bitlen_order[i]] =
				ReadBits(3)
		end

		local rle_codes_err, rle_codes_huffman_bitlen_counts,
		rle_codes_huffman_symbols, rle_codes_huffman_min_bitlen =
			GetHuffmanForDecode(rle_codes_huffman_bitlens, 18, 7)
		if rle_codes_err ~= 0 then -- Require complete code set here
			-- dynamic block code description: code lengths codes incomplete
			return -4
		end

		local lcodes_huffman_bitlens = {}
		local dcodes_huffman_bitlens = {}
		-- Read length/literal and distance code length tables
		local index = 0
		while index < nlen + ndist do
			local symbol -- Decoded value
			local bitlen -- Last length to repeat

			symbol = Decode(rle_codes_huffman_bitlen_counts
				, rle_codes_huffman_symbols, rle_codes_huffman_min_bitlen)

			if symbol < 0 then
				return symbol -- Invalid symbol
			elseif symbol < 16 then
				if index < nlen then
					lcodes_huffman_bitlens[index] = symbol
				else
					dcodes_huffman_bitlens[index-nlen] = symbol
				end
				index = index + 1
			else
				bitlen = 0
				if symbol == 16 then
					if index == 0 then
						-- dynamic block code description: repeat lengths
						-- with no first length
						return -5
					end
					if index-1 < nlen then
						bitlen = lcodes_huffman_bitlens[index-1]
					else
						bitlen = dcodes_huffman_bitlens[index-nlen-1]
					end
					symbol = 3 + ReadBits(2)
				elseif symbol == 17 then -- Repeat zero 3..10 times
					symbol = 3 + ReadBits(3)
				else -- == 18, repeat zero 11.138 times
					symbol = 11 + ReadBits(7)
				end
				if index + symbol > nlen + ndist then
					-- dynamic block code description:
					-- repeat more than specified lengths
					return -6
				end
				while symbol > 0 do -- Repeat last or zero symbol times
					symbol = symbol - 1
					if index < nlen then
						lcodes_huffman_bitlens[index] = bitlen
					else
						dcodes_huffman_bitlens[index-nlen] = bitlen
					end
					index = index + 1
				end
			end
		end

		if (lcodes_huffman_bitlens[256] or 0) == 0 then
			-- dynamic block code description: missing end-of-block code
			return -9
		end

		local lcodes_err, lcodes_huffman_bitlen_counts
		, lcodes_huffman_symbols, lcodes_huffman_min_bitlen =
			GetHuffmanForDecode(lcodes_huffman_bitlens, nlen-1, 15)
		--dynamic block code description: invalid literal/length code lengths,
		-- Incomplete code ok only for single length 1 code
		if (lcodes_err ~=0 and (lcodes_err < 0
			or nlen ~= (lcodes_huffman_bitlen_counts[0] or 0)
			+(lcodes_huffman_bitlen_counts[1] or 0))) then
			return -7
		end

		local dcodes_err, dcodes_huffman_bitlen_counts
		, dcodes_huffman_symbols, dcodes_huffman_min_bitlen =
			GetHuffmanForDecode(dcodes_huffman_bitlens, ndist-1, 15)
		-- dynamic block code description: invalid distance code lengths,
		-- Incomplete code ok only for single length 1 code
		if (dcodes_err ~=0 and (dcodes_err < 0
			or ndist ~= (dcodes_huffman_bitlen_counts[0] or 0)
			+ (dcodes_huffman_bitlen_counts[1] or 0))) then
			return -8
		end

		-- Build buffman table for literal/length codes
		return DecodeUntilEndOfBlock(state, lcodes_huffman_bitlen_counts
			, lcodes_huffman_symbols, lcodes_huffman_min_bitlen
			, dcodes_huffman_bitlen_counts, dcodes_huffman_symbols
			, dcodes_huffman_min_bitlen)
	end

	-- Decompress a deflate stream
	-- @param state: a decompression state
	-- @return the decompressed string if succeeds. nil if fails.
	local function Inflate(state)
		local ReadBits = state.ReadBits

		local is_last_block
		while not is_last_block do
			is_last_block = (ReadBits(1) == 1)
			local block_type = ReadBits(2)
			local status
			if block_type == 0 then
				status = DecompressStoreBlock(state)
			elseif block_type == 1 then
				status = DecompressFixBlock(state)
			elseif block_type == 2 then
				status = DecompressDynamicBlock(state)
			else
				return nil, -1 -- invalid block type (type == 3)
			end
			if status ~= 0 then
				return nil, status
			end
		end

		state.result_buffer[#state.result_buffer+1] =
			table_concat(state.buffer, "", 1, state.buffer_size)
		local result = table_concat(state.result_buffer)
		return result
	end

	-- @see LibDeflate:DecompressDeflate(str)
	-- @see LibDeflate:DecompressDeflateWithDict(str, dictionary)
	local function DecompressDeflateInternal(str, dictionary)
		local state = CreateDecompressState(str, dictionary)
		local result, status = Inflate(state)
		if not result then
			return nil, status
		end

		local bitlen_left = state.ReaderBitlenLeft()
		local bytelen_left = (bitlen_left - bitlen_left % 8) / 8
		return result, bytelen_left
	end

	-- @see LibDeflate:DecompressZlib(str)
	-- @see LibDeflate:DecompressZlibWithDict(str)
	local function DecompressZlibInternal(str, dictionary)
		local state = CreateDecompressState(str, dictionary)
		local ReadBits = state.ReadBits

		local CMF = ReadBits(8)
		if state.ReaderBitlenLeft() < 0 then
			return nil, 2 -- available inflate data did not terminate
		end
		local CM = CMF % 16
		local CINFO = (CMF - CM) / 16
		if CM ~= 8 then
			return nil, -12 -- invalid compression method
		end
		if CINFO > 7 then
			return nil, -13 -- invalid window size
		end

		local FLG = ReadBits(8)
		if state.ReaderBitlenLeft() < 0 then
			return nil, 2 -- available inflate data did not terminate
		end
		if (CMF*256+FLG)%31 ~= 0 then
			return nil, -14 -- invalid header checksum
		end

		local FDIST = ((FLG-FLG%32)/32 % 2)
		local FLEVEL = ((FLG-FLG%64)/64 % 4) -- luacheck: ignore FLEVEL

		if FDIST == 1 then
			if not dictionary then
				return nil, -16 -- need dictonary, but dictionary is not provided.
			end
			local byte3 = ReadBits(8)
			local byte2 = ReadBits(8)
			local byte1 = ReadBits(8)
			local byte0 = ReadBits(8)
			local actual_adler32 = byte3*16777216+byte2*65536+byte1*256+byte0
			if state.ReaderBitlenLeft() < 0 then
				return nil, 2 -- available inflate data did not terminate
			end
			if not IsEqualAdler32(actual_adler32, dictionary.adler32) then
				return nil, -17 -- dictionary adler32 does not match
			end
		end
		local result, status = Inflate(state)
		if not result then
			return nil, status
		end
		state.SkipToByteBoundary()

		local adler_byte0 = ReadBits(8)
		local adler_byte1 = ReadBits(8)
		local adler_byte2 = ReadBits(8)
		local adler_byte3 = ReadBits(8)
		if state.ReaderBitlenLeft() < 0 then
			return nil, 2 -- available inflate data did not terminate
		end

		local adler32_expected = adler_byte0*16777216
			+ adler_byte1*65536 + adler_byte2*256 + adler_byte3
		local adler32_actual = LibDeflate:Adler32(result)
		if not IsEqualAdler32(adler32_expected, adler32_actual) then
			return nil, -15 -- Adler32 checksum does not match
		end

		local bitlen_left = state.ReaderBitlenLeft()
		local bytelen_left = (bitlen_left - bitlen_left % 8) / 8
		return result, bytelen_left
	end

	--- Decompress a raw deflate compressed data.
	-- @param str [string] The data to be decompressed.
	-- @return [string/nil] If the decompression succeeds, return the decompressed
	-- data. If the decompression fails, return nil. You should check if this return
	-- value is non-nil to know if the decompression succeeds.
	-- @return [integer] If the decompression succeeds, return the number of
	-- unprocessed bytes in the input compressed data. This return value is a
	-- positive integer if the input data is a valid compressed data appended by an
	-- arbitary non-empty string. This return value is 0 if the input data does not
	-- contain any extra bytes.<br>
	-- If the decompression fails (The first return value of this function is nil),
	-- this return value is undefined.
	-- @see LibDeflate:CompressDeflate
	function LibDeflate:DecompressDeflate(str)
		local arg_valid, arg_err = IsValidArguments(str)
		if not arg_valid then
			error(("Usage: LibDeflate:DecompressDeflate(str): "
				..arg_err), 2)
		end
		return DecompressDeflateInternal(str)
	end

	--- Decompress a raw deflate compressed data with a preset dictionary.
	-- @param str [string] The data to be decompressed.
	-- @param dictionary [table] The preset dictionary used by
	-- LibDeflate:CompressDeflateWithDict when the compressed data is produced.
	-- Decompression and compression must use the same dictionary.
	-- Otherwise wrong decompressed data could be produced without generating any
	-- error.
	-- @return [string/nil] If the decompression succeeds, return the decompressed
	-- data. If the decompression fails, return nil. You should check if this return
	-- value is non-nil to know if the decompression succeeds.
	-- @return [integer] If the decompression succeeds, return the number of
	-- unprocessed bytes in the input compressed data. This return value is a
	-- positive integer if the input data is a valid compressed data appended by an
	-- arbitary non-empty string. This return value is 0 if the input data does not
	-- contain any extra bytes.<br>
	-- If the decompression fails (The first return value of this function is nil),
	-- this return value is undefined.
	-- @see LibDeflate:CompressDeflateWithDict
	function LibDeflate:DecompressDeflateWithDict(str, dictionary)
		local arg_valid, arg_err = IsValidArguments(str, true, dictionary)
		if not arg_valid then
			error(("Usage: LibDeflate:DecompressDeflateWithDict(str, dictionary): "
				..arg_err), 2)
		end
		return DecompressDeflateInternal(str, dictionary)
	end

	--- Decompress a zlib compressed data.
	-- @param str [string] The data to be decompressed
	-- @return [string/nil] If the decompression succeeds, return the decompressed
	-- data. If the decompression fails, return nil. You should check if this return
	-- value is non-nil to know if the decompression succeeds.
	-- @return [integer] If the decompression succeeds, return the number of
	-- unprocessed bytes in the input compressed data. This return value is a
	-- positive integer if the input data is a valid compressed data appended by an
	-- arbitary non-empty string. This return value is 0 if the input data does not
	-- contain any extra bytes.<br>
	-- If the decompression fails (The first return value of this function is nil),
	-- this return value is undefined.
	-- @see LibDeflate:CompressZlib
	function LibDeflate:DecompressZlib(str)
		local arg_valid, arg_err = IsValidArguments(str)
		if not arg_valid then
			error(("Usage: LibDeflate:DecompressZlib(str): "
				..arg_err), 2)
		end
		return DecompressZlibInternal(str)
	end

	--- Decompress a zlib compressed data with a preset dictionary.
	-- @param str [string] The data to be decompressed
	-- @param dictionary [table] The preset dictionary used by
	-- LibDeflate:CompressDeflateWithDict when the compressed data is produced.
	-- Decompression and compression must use the same dictionary.
	-- Otherwise wrong decompressed data could be produced without generating any
	-- error.
	-- @return [string/nil] If the decompression succeeds, return the decompressed
	-- data. If the decompression fails, return nil. You should check if this return
	-- value is non-nil to know if the decompression succeeds.
	-- @return [integer] If the decompression succeeds, return the number of
	-- unprocessed bytes in the input compressed data. This return value is a
	-- positive integer if the input data is a valid compressed data appended by an
	-- arbitary non-empty string. This return value is 0 if the input data does not
	-- contain any extra bytes.<br>
	-- If the decompression fails (The first return value of this function is nil),
	-- this return value is undefined.
	-- @see LibDeflate:CompressZlibWithDict
	function LibDeflate:DecompressZlibWithDict(str, dictionary)
		local arg_valid, arg_err = IsValidArguments(str, true, dictionary)
		if not arg_valid then
			error(("Usage: LibDeflate:DecompressZlibWithDict(str, dictionary): "
				..arg_err), 2)
		end
		return DecompressZlibInternal(str, dictionary)
	end

	-- Calculate the huffman code of fixed block
	do
		_fix_block_literal_huffman_bitlen = {}
		for sym=0, 143 do
			_fix_block_literal_huffman_bitlen[sym] = 8
		end
		for sym=144, 255 do
			_fix_block_literal_huffman_bitlen[sym] = 9
		end
		for sym=256, 279 do
			_fix_block_literal_huffman_bitlen[sym] = 7
		end
		for sym=280, 287 do
			_fix_block_literal_huffman_bitlen[sym] = 8
		end

		_fix_block_dist_huffman_bitlen = {}
		for dist=0, 31 do
			_fix_block_dist_huffman_bitlen[dist] = 5
		end
		local status
		status, _fix_block_literal_huffman_bitlen_count
		, _fix_block_literal_huffman_to_deflate_code =
			GetHuffmanForDecode(_fix_block_literal_huffman_bitlen, 287, 9)
		assert(status == 0)
		status, _fix_block_dist_huffman_bitlen_count,
		_fix_block_dist_huffman_to_deflate_code =
			GetHuffmanForDecode(_fix_block_dist_huffman_bitlen, 31, 5)
		assert(status == 0)

		_fix_block_literal_huffman_code =
			GetHuffmanCodeFromBitlen(_fix_block_literal_huffman_bitlen_count
				, _fix_block_literal_huffman_bitlen, 287, 9)
		_fix_block_dist_huffman_code =
			GetHuffmanCodeFromBitlen(_fix_block_dist_huffman_bitlen_count
				, _fix_block_dist_huffman_bitlen, 31, 5)
	end

	-- Prefix encoding algorithm
	-- Credits to LibCompress.
	-- The code has been rewritten by the author of LibDeflate.
	------------------------------------------------------------------------------

	-- to be able to match any requested byte value, the search
	-- string must be preprocessed characters to escape with %:
	-- ( ) . % + - * ? [ ] ^ $
	-- "illegal" byte values:
	-- 0 is replaces %z
	local _gsub_escape_table = {
		["\000"] = "%z", ["("] = "%(", [")"] = "%)", ["."] = "%.",
		["%"] = "%%", ["+"] = "%+", ["-"] = "%-", ["*"] = "%*",
		["?"] = "%?", ["["] = "%[", ["]"] = "%]", ["^"] = "%^",
		["$"] = "%$",
	}

	local function escape_for_gsub(str)
		return str:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", _gsub_escape_table)
	end

	--- Create a custom codec with encoder and decoder. <br>
	-- This codec is used to convert an input string to make it not contain
	-- some specific bytes.
	-- This created codec and the parameters of this function do NOT take
	-- localization into account. One byte (0-255) in the string is exactly one
	-- character (0-255).
	-- Credits to LibCompress.
	-- The code has been rewritten by the author of LibDeflate. <br>
	-- @param reserved_chars [string] The created encoder will ensure encoded
	-- data does not contain any single character in reserved_chars. This parameter
	-- should be non-empty.
	-- @param escape_chars [string] The escape character(s) used in the created
	-- codec. The codec converts any character included in reserved\_chars /
	-- escape\_chars / map\_chars to (one escape char + one character not in
	-- reserved\_chars / escape\_chars / map\_chars).
	-- You usually only need to provide a length-1 string for this parameter.
	-- Length-2 string is only needed when
	-- reserved\_chars + escape\_chars + map\_chars is longer than 127.
	-- This parameter should be non-empty.
	-- @param map_chars [string] The created encoder will map every
	-- reserved\_chars:sub(i, i) (1 <= i <= #map\_chars) to map\_chars:sub(i, i).
	-- This parameter CAN be empty string.
	-- @return [table/nil] If the codec cannot be created, return nil.<br>
	-- If the codec can be created according to the given
	-- parameters, return the codec, which is a encode/decode table.
	-- The table contains two functions: <br>
	-- t:Encode(str) returns the encoded string. <br>
	-- t:Decode(str) returns the decoded string if succeeds. nil if fails.
	-- @return [nil/string] If the codec is successfully created, return nil.
	-- If not, return a string that describes the reason why the codec cannot be
	-- created.
	-- @usage
	-- -- Create an encoder/decoder that maps all "\000" to "\003",
	-- -- and escape "\001" (and "\002" and "\003") properly
	-- local codec = LibDeflate:CreateCodec("\000\001", "\002", "\003")
	--
	-- local encoded = codec:Encode(SOME_STRING)
	-- -- "encoded" does not contain "\000" or "\001"
	-- local decoded = codec:Decode(encoded)
	-- -- assert(decoded == SOME_STRING)
	function LibDeflate:CreateCodec(reserved_chars, escape_chars
		, map_chars)
		if type(reserved_chars) ~= "string"
			or type(escape_chars) ~= "string"
			or type(map_chars) ~= "string" then
			error(
				"Usage: LibDeflate:CreateCodec(reserved_chars,"
					.." escape_chars, map_chars):"
					.." All arguments must be string.", 2)
		end

		if escape_chars == "" then
			return nil, "No escape characters supplied."
		end
		if #reserved_chars < #map_chars then
			return nil, "The number of reserved characters must be"
				.." at least as many as the number of mapped chars."
		end
		if reserved_chars == "" then
			return nil, "No characters to encode."
		end

		local encode_bytes = reserved_chars..escape_chars..map_chars
		-- build list of bytes not available as a suffix to a prefix byte
		local taken = {}
		for i = 1, #encode_bytes do
			local byte = string_byte(encode_bytes, i, i)
			if taken[byte] then
				return nil, "There must be no duplicate characters in the"
					.." concatenation of reserved_chars, escape_chars and"
					.." map_chars."
			end
			taken[byte] = true
		end

		local decode_patterns = {}
		local decode_repls = {}

		-- the encoding can be a single gsub
		-- , but the decoding can require multiple gsubs
		local encode_search = {}
		local encode_translate = {}

		-- map single byte to single byte
		if #map_chars > 0 then
			local decode_search = {}
			local decode_translate = {}
			for i = 1, #map_chars do
				local from = string_sub(reserved_chars, i, i)
				local to = string_sub(map_chars, i, i)
				encode_translate[from] = to
				encode_search[#encode_search+1] = from
				decode_translate[to] = from
				decode_search[#decode_search+1] = to
			end
			decode_patterns[#decode_patterns+1] =
				"([".. escape_for_gsub(table_concat(decode_search)).."])"
			decode_repls[#decode_repls+1] = decode_translate
		end

		local escape_char_index = 1
		local escape_char = string_sub(escape_chars
			, escape_char_index, escape_char_index)
		-- map single byte to double-byte
		local r = 0 -- suffix char value to the escapeChar

		local decode_search = {}
		local decode_translate = {}
		for i = 1, #encode_bytes do
			local c = string_sub(encode_bytes, i, i)
			if not encode_translate[c] then
				while r >= 256 or taken[r] do
					r = r + 1
					if r > 255 then -- switch to next escapeChar
						decode_patterns[#decode_patterns+1] =
							escape_for_gsub(escape_char)
							.."(["
							.. escape_for_gsub(table_concat(decode_search)).."])"
						decode_repls[#decode_repls+1] = decode_translate

						escape_char_index = escape_char_index + 1
						escape_char = string_sub(escape_chars, escape_char_index
							, escape_char_index)
						r = 0
						decode_search = {}
						decode_translate = {}

						if not escape_char or escape_char == "" then
							-- actually I don't need to check
							-- "not ecape_char", but what if Lua changes
							-- the behavior of string.sub() in the future?
							-- we are out of escape chars and we need more!
							return nil, "Out of escape characters."
						end
					end
				end

				local char_r = _byte_to_char[r]
				encode_translate[c] = escape_char..char_r
				encode_search[#encode_search+1] = c
				decode_translate[char_r] = c
				decode_search[#decode_search+1] = char_r
				r = r + 1
			end
			if i == #encode_bytes then
				decode_patterns[#decode_patterns+1] =
					escape_for_gsub(escape_char).."(["
					.. escape_for_gsub(table_concat(decode_search)).."])"
				decode_repls[#decode_repls+1] = decode_translate
			end
		end

		local codec = {}

		local encode_pattern = "(["
			.. escape_for_gsub(table_concat(encode_search)).."])"
		local encode_repl = encode_translate

		function codec:Encode(str)
			if type(str) ~= "string" then
				error(("Usage: codec:Encode(str):"
					.." 'str' - string expected got '%s'."):format(type(str)), 2)
			end
			return string_gsub(str, encode_pattern, encode_repl)
		end

		local decode_tblsize = #decode_patterns
		local decode_fail_pattern = "(["
			.. escape_for_gsub(reserved_chars).."])"

		function codec:Decode(str)
			if type(str) ~= "string" then
				error(("Usage: codec:Decode(str):"
					.." 'str' - string expected got '%s'."):format(type(str)), 2)
			end
			if string_find(str, decode_fail_pattern) then
				return nil
			end
			for i = 1, decode_tblsize do
				str = string_gsub(str, decode_patterns[i], decode_repls[i])
			end
			return str
		end

		return codec
	end

	local _addon_channel_codec


	-- Credits to WeakAuras2 and Galmok for the 6 bit encoding algorithm.
	-- The code has been rewritten by the author of LibDeflate.
	-- The result of encoding will be 25% larger than the
	-- origin string, but every single byte of the encoding result will be
	-- printable characters as the following.
	local _byte_to_6bit_char = {
		[0]="a", "b", "c", "d", "e", "f", "g", "h",
		"i", "j", "k", "l", "m", "n", "o", "p",
		"q", "r", "s", "t", "u", "v", "w", "x",
		"y", "z", "A", "B", "C", "D", "E", "F",
		"G", "H", "I", "J", "K", "L", "M", "N",
		"O", "P", "Q", "R", "S", "T", "U", "V",
		"W", "X", "Y", "Z", "0", "1", "2", "3",
		"4", "5", "6", "7", "8", "9", "(", ")",
	}

	local _6bit_to_byte = {
		[97]=0,[98]=1,[99]=2,[100]=3,[101]=4,[102]=5,[103]=6,[104]=7,
		[105]=8,[106]=9,[107]=10,[108]=11,[109]=12,[110]=13,[111]=14,[112]=15,
		[113]=16,[114]=17,[115]=18,[116]=19,[117]=20,[118]=21,[119]=22,[120]=23,
		[121]=24,[122]=25,[65]=26,[66]=27,[67]=28,[68]=29,[69]=30,[70]=31,
		[71]=32,[72]=33,[73]=34,[74]=35,[75]=36,[76]=37,[77]=38,[78]=39,
		[79]=40,[80]=41,[81]=42,[82]=43,[83]=44,[84]=45,[85]=46,[86]=47,
		[87]=48,[88]=49,[89]=50,[90]=51,[48]=52,[49]=53,[50]=54,[51]=55,
		[52]=56,[53]=57,[54]=58,[55]=59,[56]=60,[57]=61,[40]=62,[41]=63,
	}

	--- Encode the string to make it printable. <br>
	--
	-- Credit to WeakAuras2, this function is equivalant to the implementation
	-- it is using right now. <br>
	-- The code has been rewritten by the author of LibDeflate. <br>
	-- The encoded string will be 25% larger than the origin string. However, every
	-- single byte of the encoded string will be one of 64 printable ASCII
	-- characters, which are can be easier copied, pasted and displayed.
	-- (26 lowercase letters, 26 uppercase letters, 10 numbers digits,
	-- left parenthese, or right parenthese)
	-- @param str [string] The string to be encoded.
	-- @return [string] The encoded string.
	function LibDeflate:EncodeForPrint(str)
		if type(str) ~= "string" then
			error(("Usage: LibDeflate:EncodeForPrint(str):"
				.." 'str' - string expected got '%s'."):format(type(str)), 2)
		end
		local strlen = #str
		local strlenMinus2 = strlen - 2
		local i = 1
		local buffer = {}
		local buffer_size = 0
		while i <= strlenMinus2 do
			local x1, x2, x3 = string_byte(str, i, i+2)
			i = i + 3
			local cache = x1+x2*256+x3*65536
			local b1 = cache % 64
			cache = (cache - b1) / 64
			local b2 = cache % 64
			cache = (cache - b2) / 64
			local b3 = cache % 64
			local b4 = (cache - b3) / 64
			buffer_size = buffer_size + 1
			buffer[buffer_size] =
				_byte_to_6bit_char[b1].._byte_to_6bit_char[b2]
				.._byte_to_6bit_char[b3].._byte_to_6bit_char[b4]
		end

		local cache = 0
		local cache_bitlen = 0
		while i <= strlen do
			local x = string_byte(str, i, i)
			cache = cache + x * _pow2[cache_bitlen]
			cache_bitlen = cache_bitlen + 8
			i = i + 1
		end
		while cache_bitlen > 0 do
			local bit6 = cache % 64
			buffer_size = buffer_size + 1
			buffer[buffer_size] = _byte_to_6bit_char[bit6]
			cache = (cache - bit6) / 64
			cache_bitlen = cache_bitlen - 6
		end

		return table_concat(buffer)
	end

	--- Decode the printable string produced by LibDeflate:EncodeForPrint.
	-- "str" will have its prefixed and trailing control characters or space
	-- removed before it is decoded, so it is easier to use if "str" comes form
	-- user copy and paste with some prefixed or trailing spaces.
	-- Then decode fails if the string contains any characters cant be produced by
	-- LibDeflate:EncodeForPrint. That means, decode fails if the string contains a
	-- characters NOT one of 26 lowercase letters, 26 uppercase letters,
	-- 10 numbers digits, left parenthese, or right parenthese.
	-- @param str [string] The string to be decoded
	-- @return [string/nil] The decoded string if succeeds. nil if fails.
	function LibDeflate:DecodeForPrint(str)
		if type(str) ~= "string" then
			error(("Usage: LibDeflate:DecodeForPrint(str):"
				.." 'str' - string expected got '%s'."):format(type(str)), 2)
		end
		str = str:gsub("^[%c ]+", "")
		str = str:gsub("[%c ]+$", "")

		local strlen = #str
		if strlen == 1 then
			return nil
		end
		local strlenMinus3 = strlen - 3
		local i = 1
		local buffer = {}
		local buffer_size = 0
		while i <= strlenMinus3 do
			local x1, x2, x3, x4 = string_byte(str, i, i+3)
			x1 = _6bit_to_byte[x1]
			x2 = _6bit_to_byte[x2]
			x3 = _6bit_to_byte[x3]
			x4 = _6bit_to_byte[x4]
			if not (x1 and x2 and x3 and x4) then
				return nil
			end
			i = i + 4
			local cache = x1+x2*64+x3*4096+x4*262144
			local b1 = cache % 256
			cache = (cache - b1) / 256
			local b2 = cache % 256
			local b3 = (cache - b2) / 256
			buffer_size = buffer_size + 1
			buffer[buffer_size] =
				_byte_to_char[b1].._byte_to_char[b2].._byte_to_char[b3]
		end

		local cache  = 0
		local cache_bitlen = 0
		while i <= strlen do
			local x = string_byte(str, i, i)
			x =  _6bit_to_byte[x]
			if not x then
				return nil
			end
			cache = cache + x * _pow2[cache_bitlen]
			cache_bitlen = cache_bitlen + 6
			i = i + 1
		end

		while cache_bitlen >= 8 do
			local byte = cache % 256
			buffer_size = buffer_size + 1
			buffer[buffer_size] = _byte_to_char[byte]
			cache = (cache - byte) / 256
			cache_bitlen = cache_bitlen - 8
		end

		return table_concat(buffer)
	end

	local function InternalClearCache()
		_addon_channel_codec = nil
	end

	-- For test. Don't use the functions in this table for real application.
	-- Stuffs in this table is subject to change.
	LibDeflate.internals = {
		LoadStringToTable = LoadStringToTable,
		IsValidDictionary = IsValidDictionary,
		IsEqualAdler32 = IsEqualAdler32,
		_byte_to_6bit_char = _byte_to_6bit_char,
		_6bit_to_byte = _6bit_to_byte,
		InternalClearCache = InternalClearCache,
	}

	local compression = Compression

	local utility = {};
	local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

	function utility.base64decode(data)
		data = string.gsub(data, '[^'..b..'=]', '')
		return (data:gsub('.', function(x)
			if (x == '=') then return '' end
			local r,f='',(b:find(x)-1)
			for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
			return r;
		end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
			if (#x ~= 8) then return '' end
			local c=0
			for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
			return string.char(c)
		end))
	end

	function utility.base64encode(data)
		return ((data:gsub('.', function(x) 
			local r,b='',x:byte()
			for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
			return r;
		end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
			if (#x < 6) then return '' end
			local c=0
			for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
			return b:sub(c+1,c+1)
		end)..({ '', '==', '=' })[#data%3+1])
	end

	function utility.rawCompress(txt)
		return (compression.Zlib.Compress(txt,{
			strategy = "dynamic",
			level = 9
		}));
	end

	function utility.rawDecompress(txt)
		return compression.Zlib.Decompress(txt,{
			strategy = "dynamic",
			level = 9
		});
	end

	function utility.compress(txt)
		return utility.base64encode(compression.Zlib.Compress(txt,{
			strategy = "dynamic",
			level = 9
		}));
	end

	function utility.decompress(txt)
		return compression.Zlib.Decompress(utility.base64decode(txt),{
			strategy = "dynamic",
			level = 9
		});
	end
	return utility
end

local vmModule = function()
	--[[
	Credit to einsteinK.
	Credit to Stravant for LBI.

	Credit to the creators of all the other modules used in this.

	Sceleratis was here and decided modify some things.

	einsteinK was here again to fix a bug in LBI for if-statements
--]]

--[[--------------------------------------------------------------------

  llex.lua
  Lua lexical analyzer in Lua
  This file is part of Yueliang.

  Copyright (c) 2005-2006 Kein-Hong Man <khman@users.sf.net>
  The COPYRIGHT file describes the conditions
  under which this software may be distributed.

  See the ChangeLog for more information.

----------------------------------------------------------------------]]

--[[--------------------------------------------------------------------
-- Notes:
-- * intended to 'imitate' llex.c code; performance is not a concern
-- * tokens are strings; code structure largely retained
-- * deleted stuff (compared to llex.c) are noted, comments retained
-- * nextc() returns the currently read character to simplify coding
--   here; next() in llex.c does not return anything
-- * compatibility code is marked with "--#" comments
--
-- Added:
-- * luaX:chunkid (function luaO_chunkid from lobject.c)
-- * luaX:str2d (function luaO_str2d from lobject.c)
-- * luaX.LUA_QS used in luaX:lexerror (from luaconf.h)
-- * luaX.LUA_COMPAT_LSTR in luaX:read_long_string (from luaconf.h)
-- * luaX.MAX_INT used in luaX:inclinenumber (from llimits.h)
--
-- To use the lexer:
-- (1) luaX:init() to initialize the lexer
-- (2) luaX:setinput() to set the input stream to lex
-- (3) call luaX:next() or luaX:luaX:lookahead() to get tokens,
--     until "TK_EOS": luaX:next()
-- * since EOZ is returned as a string, be careful when regexp testing
--
-- Not implemented:
-- * luaX_newstring: not required by this Lua implementation
-- * buffer MAX_SIZET size limit (from llimits.h) test not implemented
--   in the interest of performance
-- * locale-aware number handling is largely redundant as Lua's
--   tonumber() function is already capable of this
--
-- Changed in 5.1.x:
-- * TK_NAME token order moved down
-- * string representation for TK_NAME, TK_NUMBER, TK_STRING changed
-- * token struct renamed to lower case (LS -> ls)
-- * LexState struct: removed nestlevel, added decpoint
-- * error message functions have been greatly simplified
-- * token2string renamed to luaX_tokens, exposed in llex.h
-- * lexer now handles all kinds of newlines, including CRLF
-- * shbang first line handling removed from luaX:setinput;
--   it is now done in lauxlib.c (luaL_loadfile)
-- * next(ls) macro renamed to nextc(ls) due to new luaX_next function
-- * EXTRABUFF and MAXNOCHECK removed due to lexer changes
-- * checkbuffer(ls, len) macro deleted
-- * luaX:read_numeral now has 3 support functions: luaX:trydecpoint,
--   luaX:buffreplace and (luaO_str2d from lobject.c) luaX:str2d
-- * luaX:read_numeral is now more promiscuous in slurping characters;
--   hexadecimal numbers was added, locale-aware decimal points too
-- * luaX:skip_sep is new; used by luaX:read_long_string
-- * luaX:read_long_string handles new-style long blocks, with some
--   optional compatibility code
-- * luaX:llex: parts changed to support new-style long blocks
-- * luaX:llex: readname functionality has been folded in
-- * luaX:llex: removed test for control characters
--
--------------------------------------------------------------------]]

	local luaZ = {}

	------------------------------------------------------------------------
	-- * reader() should return a string, or nil if nothing else to parse.
	--   Additional data can be set only during stream initialization
	-- * Readers are handled in lauxlib.c, see luaL_load(file|buffer|string)
	-- * LUAL_BUFFERSIZE=BUFSIZ=512 in make_getF() (located in luaconf.h)
	-- * Original Reader typedef:
	--   const char * (*lua_Reader) (lua_State *L, void *ud, size_t *sz);
	-- * This Lua chunk reader implementation:
	--   returns string or nil, no arguments to function
	------------------------------------------------------------------------

	------------------------------------------------------------------------
	-- create a chunk reader from a source string
	------------------------------------------------------------------------
	function luaZ:make_getS(buff)
		local b = buff
		return function() -- chunk reader anonymous function here
			if not b then return nil end
			local data = b
			b = nil
			return data
		end
	end

	------------------------------------------------------------------------
	-- create a chunk reader from a source file
	------------------------------------------------------------------------
--[[
function luaZ:make_getF(filename)
  local LUAL_BUFFERSIZE = 512
  local h = io.open(filename, "r")
  if not h then return nil end
  return function() -- chunk reader anonymous function here
    if not h or io.type(h) == "closed file" then return nil end
    local buff = h:read(LUAL_BUFFERSIZE)
    if not buff then h:close(); h = nil end
    return buff
  end
end
--]]
	------------------------------------------------------------------------
	-- creates a zio input stream
	-- returns the ZIO structure, z
	------------------------------------------------------------------------
	function luaZ:init(reader, data, name)
		if not reader then return end
		local z = {}
		z.reader = reader
		z.data = data or ""
		z.name = name
		-- set up additional data for reading
		if not data or data == "" then z.n = 0 else z.n = #data end
		z.p = 0
		return z
	end

	------------------------------------------------------------------------
	-- fill up input buffer
	------------------------------------------------------------------------
	function luaZ:fill(z)
		local buff = z.reader()
		z.data = buff
		if not buff or buff == "" then return "EOZ" end
		z.n, z.p = #buff - 1, 1
		return string.sub(buff, 1, 1)
	end

	------------------------------------------------------------------------
	-- get next character from the input stream
	-- * local n, p are used to optimize code generation
	------------------------------------------------------------------------
	function luaZ:zgetc(z)
		local n, p = z.n, z.p + 1
		if n > 0 then
			z.n, z.p = n - 1, p
			return string.sub(z.data, p, p)
		else
			return self:fill(z)
		end
	end

	local luaX = {}

	-- FIRST_RESERVED is not required as tokens are manipulated as strings
	-- TOKEN_LEN deleted; maximum length of a reserved word not needed

	------------------------------------------------------------------------
	-- "ORDER RESERVED" deleted; enumeration in one place: luaX.RESERVED
	------------------------------------------------------------------------

	-- terminal symbols denoted by reserved words: TK_AND to TK_WHILE
	-- other terminal symbols: TK_NAME to TK_EOS
	luaX.RESERVED = [[
TK_AND and
TK_BREAK break
TK_DO do
TK_ELSE else
TK_ELSEIF elseif
TK_END end
TK_FALSE false
TK_FOR for
TK_FUNCTION function
TK_IF if
TK_IN in
TK_LOCAL local
TK_NIL nil
TK_NOT not
TK_OR or
TK_REPEAT repeat
TK_RETURN return
TK_THEN then
TK_TRUE true
TK_UNTIL until
TK_WHILE while
TK_CONCAT ..
TK_DOTS ...
TK_EQ ==
TK_GE >=
TK_LE <=
TK_NE ~=
TK_NAME <name>
TK_NUMBER <number>
TK_STRING <string>
TK_EOS <eof>]]

	-- NUM_RESERVED is not required; number of reserved words

--[[--------------------------------------------------------------------
-- Instead of passing seminfo, the Token struct (e.g. ls.t) is passed
-- so that lexer functions can use its table element, ls.t.seminfo
--
-- SemInfo (struct no longer needed, a mixed-type value is used)
--
-- Token (struct of ls.t and ls.lookahead):
--   token  -- token symbol
--   seminfo  -- semantics information
--
-- LexState (struct of ls; ls is initialized by luaX:setinput):
--   current  -- current character (charint)
--   linenumber  -- input line counter
--   lastline  -- line of last token 'consumed'
--   t  -- current token (table: struct Token)
--   lookahead  -- look ahead token (table: struct Token)
--   fs  -- 'FuncState' is private to the parser
--   L -- LuaState
--   z  -- input stream
--   buff  -- buffer for tokens
--   source  -- current source name
--   decpoint -- locale decimal point
--   nestlevel  -- level of nested non-terminals
----------------------------------------------------------------------]]

	-- luaX.tokens (was luaX_tokens) is now a hash; see luaX:init

	luaX.MAXSRC = 80
	luaX.MAX_INT = 2147483645       -- constants from elsewhere (see above)
	luaX.LUA_QS = "'%s'"
	luaX.LUA_COMPAT_LSTR = 1
	--luaX.MAX_SIZET = 4294967293

	------------------------------------------------------------------------
	-- initialize lexer
	-- * original luaX_init has code to create and register token strings
	-- * luaX.tokens: TK_* -> token
	-- * luaX.enums:  token -> TK_* (used in luaX:llex)
	------------------------------------------------------------------------
	function luaX:init()
		local tokens, enums = {}, {}
		for v in string.gmatch(self.RESERVED, "[^\n]+") do
			local _, _, tok, str = string.find(v, "(%S+)%s+(%S+)")
			tokens[tok] = str
			enums[str] = tok
		end
		self.tokens = tokens
		self.enums = enums
	end

	------------------------------------------------------------------------
	-- returns a suitably-formatted chunk name or id
	-- * from lobject.c, used in llex.c and ldebug.c
	-- * the result, out, is returned (was first argument)
	------------------------------------------------------------------------
	function luaX:chunkid(source, bufflen)
		local out
		local first = string.sub(source, 1, 1)
		if first == "=" then
			out = string.sub(source, 2, bufflen)  -- remove first char
		else  -- out = "source", or "...source"
			if first == "@" then
				source = string.sub(source, 2)  -- skip the '@'
				bufflen = bufflen - #" '...' "
				local l = #source
				out = ""
				if l > bufflen then
					source = string.sub(source, 1 + l - bufflen)  -- get last part of file name
					out = out.."..."
				end
				out = out..source
			else  -- out = [string "string"]
				local len = string.find(source, "[\n\r]")  -- stop at first newline
				len = len and (len - 1) or #source
				bufflen = bufflen - #(" [string \"...\"] ")
				if len > bufflen then len = bufflen end
				out = "[string \""
				if len < #source then  -- must truncate?
					out = out..string.sub(source, 1, len).."..."
				else
					out = out..source
				end
				out = out.."\"]"
			end
		end
		return out
	end

--[[--------------------------------------------------------------------
-- Support functions for lexer
-- * all lexer errors eventually reaches lexerror:
     syntaxerror -> lexerror
----------------------------------------------------------------------]]

	------------------------------------------------------------------------
	-- look up token and return keyword if found (also called by parser)
	------------------------------------------------------------------------
	function luaX:token2str(ls, token)
		if string.sub(token, 1, 3) ~= "TK_" then
			if string.find(token, "%c") then
				return string.format("char(%d)", string.byte(token))
			end
			return token
		else
		end
		return self.tokens[token]
	end

	------------------------------------------------------------------------
	-- throws a lexer error
	-- * txtToken has been made local to luaX:lexerror
	-- * can't communicate LUA_ERRSYNTAX, so it is unimplemented
	------------------------------------------------------------------------
	function luaX:lexerror(ls, msg, token)
		local function txtToken(ls, token)
			if token == "TK_NAME" or
				token == "TK_STRING" or
				token == "TK_NUMBER" then
				return ls.buff
			else
				return self:token2str(ls, token)
			end
		end
		local buff = self:chunkid(ls.source, self.MAXSRC)
		local msg = string.format("%s:%d: %s", buff, ls.linenumber, msg)
		if token then
			msg = string.format("%s near "..self.LUA_QS, msg, txtToken(ls, token))
		end
		-- luaD_throw(ls->L, LUA_ERRSYNTAX)
		error(msg)
	end

	------------------------------------------------------------------------
	-- throws a syntax error (mainly called by parser)
	-- * ls.t.token has to be set by the function calling luaX:llex
	--   (see luaX:next and luaX:lookahead elsewhere in this file)
	------------------------------------------------------------------------
	function luaX:syntaxerror(ls, msg)
		self:lexerror(ls, msg, ls.t.token)
	end

	------------------------------------------------------------------------
	-- move on to next line
	------------------------------------------------------------------------
	function luaX:currIsNewline(ls)
		return ls.current == "\n" or ls.current == "\r"
	end

	function luaX:inclinenumber(ls)
		local old = ls.current
		-- lua_assert(currIsNewline(ls))
		self:nextc(ls)  -- skip '\n' or '\r'
		if self:currIsNewline(ls) and ls.current ~= old then
			self:nextc(ls)  -- skip '\n\r' or '\r\n'
		end
		ls.linenumber = ls.linenumber + 1
		if ls.linenumber >= self.MAX_INT then
			self:syntaxerror(ls, "chunk has too many lines")
		end
	end

	------------------------------------------------------------------------
	-- initializes an input stream for lexing
	-- * if ls (the lexer state) is passed as a table, then it is filled in,
	--   otherwise it has to be retrieved as a return value
	-- * LUA_MINBUFFER not used; buffer handling not required any more
	------------------------------------------------------------------------
	function luaX:setinput(L, ls, z, source)
		if not ls then ls = {} end  -- create struct
		if not ls.lookahead then ls.lookahead = {} end
		if not ls.t then ls.t = {} end
		ls.decpoint = "."
		ls.L = L
		ls.lookahead.token = "TK_EOS"  -- no look-ahead token
		ls.z = z
		ls.fs = nil
		ls.linenumber = 1
		ls.lastline = 1
		ls.source = source
		self:nextc(ls)  -- read first char
	end

--[[--------------------------------------------------------------------
-- LEXICAL ANALYZER
----------------------------------------------------------------------]]

	------------------------------------------------------------------------
	-- checks if current character read is found in the set 'set'
	------------------------------------------------------------------------
	function luaX:check_next(ls, set)
		if not string.find(set, ls.current, 1, 1) then
			return false
		end
		self:save_and_next(ls)
		return true
	end

	------------------------------------------------------------------------
	-- retrieve next token, checking the lookahead buffer if necessary
	-- * note that the macro next(ls) in llex.c is now luaX:nextc
	-- * utilized used in lparser.c (various places)
	------------------------------------------------------------------------
	function luaX:next(ls)
		ls.lastline = ls.linenumber
		if ls.lookahead.token ~= "TK_EOS" then  -- is there a look-ahead token?
			-- this must be copy-by-value
			ls.t.seminfo = ls.lookahead.seminfo  -- use this one
			ls.t.token = ls.lookahead.token
			ls.lookahead.token = "TK_EOS"  -- and discharge it
		else
			ls.t.token = self:llex(ls, ls.t)  -- read next token
		end
	end

	------------------------------------------------------------------------
	-- fill in the lookahead buffer
	-- * utilized used in lparser.c:constructor
	------------------------------------------------------------------------
	function luaX:lookahead(ls)
		-- lua_assert(ls.lookahead.token == "TK_EOS")
		ls.lookahead.token = self:llex(ls, ls.lookahead)
	end

	------------------------------------------------------------------------
	-- gets the next character and returns it
	-- * this is the next() macro in llex.c; see notes at the beginning
	------------------------------------------------------------------------
	function luaX:nextc(ls)
		local c = luaZ:zgetc(ls.z)
		ls.current = c
		return c
	end

	------------------------------------------------------------------------
	-- saves the given character into the token buffer
	-- * buffer handling code removed, not used in this implementation
	-- * test for maximum token buffer length not used, makes things faster
	------------------------------------------------------------------------

	function luaX:save(ls, c)
		local buff = ls.buff
		-- if you want to use this, please uncomment luaX.MAX_SIZET further up
		--if #buff > self.MAX_SIZET then
		--  self:lexerror(ls, "lexical element too long")
		--end
		ls.buff = buff..c
	end

	------------------------------------------------------------------------
	-- save current character into token buffer, grabs next character
	-- * like luaX:nextc, returns the character read for convenience
	------------------------------------------------------------------------
	function luaX:save_and_next(ls)
		self:save(ls, ls.current)
		return self:nextc(ls)
	end

	------------------------------------------------------------------------
	-- LUA_NUMBER
	-- * luaX:read_numeral is the main lexer function to read a number
	-- * luaX:str2d, luaX:buffreplace, luaX:trydecpoint are support functions
	------------------------------------------------------------------------

	------------------------------------------------------------------------
	-- string to number converter (was luaO_str2d from lobject.c)
	-- * returns the number, nil if fails (originally returns a boolean)
	-- * conversion function originally lua_str2number(s,p), a macro which
	--   maps to the strtod() function by default (from luaconf.h)
	------------------------------------------------------------------------
	function luaX:str2d(s)
		local result = tonumber(s)
		if result then return result end
		-- conversion failed
		if string.lower(string.sub(s, 1, 2)) == "0x" then  -- maybe an hexadecimal constant?
			result = tonumber(s, 16)
			if result then return result end  -- most common case
			-- Was: invalid trailing characters?
			-- In C, this function then skips over trailing spaces.
			-- true is returned if nothing else is found except for spaces.
			-- If there is still something else, then it returns a false.
			-- All this is not necessary using Lua's tonumber.
		end
		return nil
	end

	------------------------------------------------------------------------
	-- single-character replacement, for locale-aware decimal points
	------------------------------------------------------------------------
	function luaX:buffreplace(ls, from, to)
		local result, buff = "", ls.buff
		for p = 1, #buff do
			local c = string.sub(buff, p, p)
			if c == from then c = to end
			result = result..c
		end
		ls.buff = result
	end

	------------------------------------------------------------------------
	-- Attempt to convert a number by translating '.' decimal points to
	-- the decimal point character used by the current locale. This is not
	-- needed in Yueliang as Lua's tonumber() is already locale-aware.
	-- Instead, the code is here in case the user implements localeconv().
	------------------------------------------------------------------------
	function luaX:trydecpoint(ls, Token)
		-- format error: try to update decimal point separator
		local old = ls.decpoint
		-- translate the following to Lua if you implement localeconv():
		-- struct lconv *cv = localeconv();
		-- ls->decpoint = (cv ? cv->decimal_point[0] : '.');
		self:buffreplace(ls, old, ls.decpoint)  -- try updated decimal separator
		local seminfo = self:str2d(ls.buff)
		Token.seminfo = seminfo
		if not seminfo then
			-- format error with correct decimal point: no more options
			self:buffreplace(ls, ls.decpoint, ".")  -- undo change (for error message)
			self:lexerror(ls, "malformed number", "TK_NUMBER")
		end
	end

	------------------------------------------------------------------------
	-- main number conversion function
	-- * "^%w$" needed in the scan in order to detect "EOZ"
	------------------------------------------------------------------------
	function luaX:read_numeral(ls, Token)
		-- lua_assert(string.find(ls.current, "%d"))
		repeat
			self:save_and_next(ls)
		until string.find(ls.current, "%D") and ls.current ~= "."
		if self:check_next(ls, "Ee") then  -- 'E'?
			self:check_next(ls, "+-")  -- optional exponent sign
		end
		while string.find(ls.current, "^%w$") or ls.current == "_" do
			self:save_and_next(ls)
		end
		self:buffreplace(ls, ".", ls.decpoint)  -- follow locale for decimal point
		local seminfo = self:str2d(ls.buff)
		Token.seminfo = seminfo
		if not seminfo then  -- format error?
			self:trydecpoint(ls, Token) -- try to update decimal point separator
		end
	end

	------------------------------------------------------------------------
	-- count separators ("=") in a long string delimiter
	-- * used by luaX:read_long_string
	------------------------------------------------------------------------
	function luaX:skip_sep(ls)
		local count = 0
		local s = ls.current
		-- lua_assert(s == "[" or s == "]")
		self:save_and_next(ls)
		while ls.current == "=" do
			self:save_and_next(ls)
			count = count + 1
		end
		return (ls.current == s) and count or (-count) - 1
	end

	------------------------------------------------------------------------
	-- reads a long string or long comment
	------------------------------------------------------------------------
	function luaX:read_long_string(ls, Token, sep)
		local cont = 0
		self:save_and_next(ls)  -- skip 2nd '['
		if self:currIsNewline(ls) then  -- string starts with a newline?
			self:inclinenumber(ls)  -- skip it
		end
		while true do
			local c = ls.current
			if c == "EOZ" then
				self:lexerror(ls, Token and "unfinished long string" or
					"unfinished long comment", "TK_EOS")
			elseif c == "[" then
				--# compatibility code start
				if self.LUA_COMPAT_LSTR then
					if self:skip_sep(ls) == sep then
						self:save_and_next(ls)  -- skip 2nd '['
						cont = cont + 1
						--# compatibility code start
						if self.LUA_COMPAT_LSTR == 1 then
							if sep == 0 then
								self:lexerror(ls, "nesting of [[...]] is deprecated", "[")
							end
						end
						--# compatibility code end
					end
				end
				--# compatibility code end
			elseif c == "]" then
				if self:skip_sep(ls) == sep then
					self:save_and_next(ls)  -- skip 2nd ']'
					--# compatibility code start
					if self.LUA_COMPAT_LSTR and self.LUA_COMPAT_LSTR == 2 then
						cont = cont - 1
						if sep == 0 and cont >= 0 then break end
					end
					--# compatibility code end
					break
				end
			elseif self:currIsNewline(ls) then
				self:save(ls, "\n")
				self:inclinenumber(ls)
				if not Token then ls.buff = "" end -- avoid wasting space
			else  -- default
				if Token then
					self:save_and_next(ls)
				else
					self:nextc(ls)
				end
			end--if c
		end--while
		if Token then
			local p = 3 + sep
			Token.seminfo = string.sub(ls.buff, p, -p)
		end
	end

	------------------------------------------------------------------------
	-- reads a string
	-- * has been restructured significantly compared to the original C code
	------------------------------------------------------------------------

	function luaX:read_string(ls, del, Token)
		self:save_and_next(ls)
		while ls.current ~= del do
			local c = ls.current
			if c == "EOZ" then
				self:lexerror(ls, "unfinished string", "TK_EOS")
			elseif self:currIsNewline(ls) then
				self:lexerror(ls, "unfinished string", "TK_STRING")
			elseif c == "\\" then
				c = self:nextc(ls)  -- do not save the '\'
				if self:currIsNewline(ls) then  -- go through
					self:save(ls, "\n")
					self:inclinenumber(ls)
				elseif c ~= "EOZ" then -- will raise an error next loop
					-- escapes handling greatly simplified here:
					local i = string.find("abfnrtv", c, 1, 1)
					if i then
						self:save(ls, string.sub("\a\b\f\n\r\t\v", i, i))
						self:nextc(ls)
					elseif not string.find(c, "%d") then
						self:save_and_next(ls)  -- handles \\, \", \', and \?
					else  -- \xxx
						c, i = 0, 0
						repeat
							c = 10 * c + ls.current
							self:nextc(ls)
							i = i + 1
						until i >= 3 or not string.find(ls.current, "%d")
						if c > 255 then  -- UCHAR_MAX
							self:lexerror(ls, "escape sequence too large", "TK_STRING")
						end
						self:save(ls, string.char(c))
					end
				end
			else
				self:save_and_next(ls)
			end--if c
		end--while
		self:save_and_next(ls)  -- skip delimiter
		Token.seminfo = string.sub(ls.buff, 2, -2)
	end

	------------------------------------------------------------------------
	-- main lexer function
	------------------------------------------------------------------------
	function luaX:llex(ls, Token)
		ls.buff = ""
		while true do
			local c = ls.current
			----------------------------------------------------------------
			if self:currIsNewline(ls) then
				self:inclinenumber(ls)
				----------------------------------------------------------------
			elseif c == "-" then
				c = self:nextc(ls)
				if c ~= "-" then return "-" end
				-- else is a comment
				local sep = -1
				if self:nextc(ls) == '[' then
					sep = self:skip_sep(ls)
					ls.buff = ""  -- 'skip_sep' may dirty the buffer
				end
				if sep >= 0 then
					self:read_long_string(ls, nil, sep)  -- long comment
					ls.buff = ""
				else  -- else short comment
					while not self:currIsNewline(ls) and ls.current ~= "EOZ" do
						self:nextc(ls)
					end
				end
				----------------------------------------------------------------
			elseif c == "[" then
				local sep = self:skip_sep(ls)
				if sep >= 0 then
					self:read_long_string(ls, Token, sep)
					return "TK_STRING"
				elseif sep == -1 then
					return "["
				else
					self:lexerror(ls, "invalid long string delimiter", "TK_STRING")
				end
				----------------------------------------------------------------
			elseif c == "=" then
				c = self:nextc(ls)
				if c ~= "=" then return "="
				else self:nextc(ls); return "TK_EQ" end
				----------------------------------------------------------------
			elseif c == "<" then
				c = self:nextc(ls)
				if c ~= "=" then return "<"
				else self:nextc(ls); return "TK_LE" end
				----------------------------------------------------------------
			elseif c == ">" then
				c = self:nextc(ls)
				if c ~= "=" then return ">"
				else self:nextc(ls); return "TK_GE" end
				----------------------------------------------------------------
			elseif c == "~" then
				c = self:nextc(ls)
				if c ~= "=" then return "~"
				else self:nextc(ls); return "TK_NE" end
				----------------------------------------------------------------
			elseif c == "\"" or c == "'" then
				self:read_string(ls, c, Token)
				return "TK_STRING"
				----------------------------------------------------------------
			elseif c == "." then
				c = self:save_and_next(ls)
				if self:check_next(ls, ".") then
					if self:check_next(ls, ".") then
						return "TK_DOTS"   -- ...
					else return "TK_CONCAT"   -- ..
					end
				elseif not string.find(c, "%d") then
					return "."
				else
					self:read_numeral(ls, Token)
					return "TK_NUMBER"
				end
				----------------------------------------------------------------
			elseif c == "EOZ" then
				return "TK_EOS"
				----------------------------------------------------------------
			else  -- default
				if string.find(c, "%s") then
					-- lua_assert(self:currIsNewline(ls))
					self:nextc(ls)
				elseif string.find(c, "%d") then
					self:read_numeral(ls, Token)
					return "TK_NUMBER"
				elseif string.find(c, "[_%a]") then
					-- identifier or reserved word
					repeat
						c = self:save_and_next(ls)
					until c == "EOZ" or not string.find(c, "[_%w]")
					local ts = ls.buff
					local tok = self.enums[ts]
					if tok then return tok end  -- reserved word?
					Token.seminfo = ts
					return "TK_NAME"
				else
					self:nextc(ls)
					return c  -- single-char tokens (+ - / ...)
				end
				----------------------------------------------------------------
			end--if c
		end--while
	end

--[[--------------------------------------------------------------------

  lparser.lua
  Lua 5 parser in Lua
  This file is part of Yueliang.

  Copyright (c) 2005-2007 Kein-Hong Man <khman@users.sf.net>
  The COPYRIGHT file describes the conditions
  under which this software may be distributed.

  See the ChangeLog for more information.

----------------------------------------------------------------------]]

--[[--------------------------------------------------------------------
-- Notes:
-- * some unused C code that were not converted are kept as comments
-- * LUA_COMPAT_VARARG option changed into a comment block
-- * for value/size specific code added, look for 'NOTE: '
--
-- Not implemented:
-- * luaX_newstring not needed by this Lua implementation
-- * luaG_checkcode() in assert is not currently implemented
--
-- Added:
-- * some constants added from various header files
-- * luaY.LUA_QS used in error_expected, check_match (from luaconf.h)
-- * luaY:LUA_QL needed for error messages (from luaconf.h)
-- * luaY:growvector (from lmem.h) -- skeleton only, limit checking
-- * luaY.SHRT_MAX (from <limits.h>) for registerlocalvar
-- * luaY:newproto (from lfunc.c)
-- * luaY:int2fb (from lobject.c)
-- * NOTE: HASARG_MASK, for implementing a VARARG_HASARG bit operation
-- * NOTE: value-specific code for VARARG_NEEDSARG to replace a bitop
--
-- Changed in 5.1.x:
-- * various code changes are not detailed...
-- * names of constants may have changed, e.g. added a LUAI_ prefix
-- * struct expkind: added VKNUM, VVARARG; VCALL's info changed?
-- * struct expdesc: added nval
-- * struct FuncState: upvalues data type changed to upvaldesc
-- * macro hasmultret is new
-- * function checklimit moved to parser from lexer
-- * functions anchor_token, errorlimit, checknext are new
-- * checknext is new, equivalent to 5.0.x's check, see check too
-- * luaY:next and luaY:lookahead moved to lexer
-- * break keyword no longer skipped in luaY:breakstat
-- * function new_localvarstr replaced by new_localvarliteral
-- * registerlocalvar limits local variables to SHRT_MAX
-- * create_local deleted, new_localvarliteral used instead
-- * constant LUAI_MAXUPVALUES increased to 60
-- * constants MAXPARAMS, LUA_MAXPARSERLEVEL, MAXSTACK removed
-- * function interface changed: singlevaraux, singlevar
-- * enterlevel and leavelevel uses nCcalls to track call depth
-- * added a name argument to main entry function, luaY:parser
-- * function luaY_index changed to yindex
-- * luaY:int2fb()'s table size encoding format has been changed
-- * luaY:log2() no longer needed for table constructors
-- * function code_params deleted, functionality folded in parlist
-- * vararg flags handling (is_vararg) changes; also see VARARG_*
-- * LUA_COMPATUPSYNTAX section for old-style upvalues removed
-- * repeatstat() calls chunk() instead of block()
-- * function interface changed: cond, test_then_block
-- * while statement implementation considerably simplified; MAXEXPWHILE
--   and EXTRAEXP no longer required, no limits to the complexity of a
--   while condition
-- * repeat, forbody statement implementation has major changes,
--   mostly due to new scoping behaviour of local variables
-- * OPR_MULT renamed to OPR_MUL
----------------------------------------------------------------------]]

	--requires luaP, luaX, luaK
	local luaY = {}

--[[--------------------------------------------------------------------

  lcode.lua
  Lua 5 code generator in Lua
  This file is part of Yueliang.

  Copyright (c) 2005-2007 Kein-Hong Man <khman@users.sf.net>
  The COPYRIGHT file describes the conditions
  under which this software may be distributed.

  See the ChangeLog for more information.

----------------------------------------------------------------------]]

--[[--------------------------------------------------------------------
-- Notes:
-- * one function manipulate a pointer argument with a simple data type
--   (can't be emulated by a table, ambiguous), now returns that value:
--   luaK:concat(fs, l1, l2)
-- * luaM_growvector uses the faux luaY:growvector, for limit checking
-- * some function parameters changed to boolean, additional code
--   translates boolean back to 1/0 for instruction fields
--
-- Not implemented:
-- * NOTE there is a failed assert in luaK:addk, a porting problem
--
-- Added:
-- * constant MAXSTACK from llimits.h
-- * luaK:ttisnumber(o) (from lobject.h)
-- * luaK:nvalue(o) (from lobject.h)
-- * luaK:setnilvalue(o) (from lobject.h)
-- * luaK:setnvalue(o, x) (from lobject.h)
-- * luaK:setbvalue(o, x) (from lobject.h)
-- * luaK:sethvalue(o, x) (from lobject.h), parameter L deleted
-- * luaK:setsvalue(o, x) (from lobject.h), parameter L deleted
-- * luaK:numadd, luaK:numsub, luaK:nummul, luaK:numdiv, luaK:nummod,
--   luaK:numpow, luaK:numunm, luaK:numisnan (from luaconf.h)
-- * copyexp(e1, e2) added in luaK:posfix to copy expdesc struct
--
-- Changed in 5.1.x:
-- * enum BinOpr has a new entry, OPR_MOD
-- * enum UnOpr has a new entry, OPR_LEN
-- * binopistest, unused in 5.0.x, has been deleted
-- * macro setmultret is new
-- * functions isnumeral, luaK_ret, boolK are new
-- * funcion nilK was named nil_constant in 5.0.x
-- * function interface changed: need_value, patchtestreg, concat
-- * TObject now a TValue
-- * functions luaK_setreturns, luaK_setoneret are new
-- * function luaK:setcallreturns deleted, to be replaced by:
--   luaK:setmultret, luaK:ret, luaK:setreturns, luaK:setoneret
-- * functions constfolding, codearith, codecomp are new
-- * luaK:codebinop has been deleted
-- * function luaK_setlist is new
-- * OPR_MULT renamed to OPR_MUL
----------------------------------------------------------------------]]

--[[--------------------------------------------------------------------

  lcode.lua
  Lua 5 code generator in Lua
  This file is part of Yueliang.

  Copyright (c) 2005-2007 Kein-Hong Man <khman@users.sf.net>
  The COPYRIGHT file describes the conditions
  under which this software may be distributed.

  See the ChangeLog for more information.

----------------------------------------------------------------------]]

--[[--------------------------------------------------------------------
-- Notes:
-- * one function manipulate a pointer argument with a simple data type
--   (can't be emulated by a table, ambiguous), now returns that value:
--   luaK:concat(fs, l1, l2)
-- * luaM_growvector uses the faux luaY:growvector, for limit checking
-- * some function parameters changed to boolean, additional code
--   translates boolean back to 1/0 for instruction fields
--
-- Not implemented:
-- * NOTE there is a failed assert in luaK:addk, a porting problem
--
-- Added:
-- * constant MAXSTACK from llimits.h
-- * luaK:ttisnumber(o) (from lobject.h)
-- * luaK:nvalue(o) (from lobject.h)
-- * luaK:setnilvalue(o) (from lobject.h)
-- * luaK:setnvalue(o, x) (from lobject.h)
-- * luaK:setbvalue(o, x) (from lobject.h)
-- * luaK:sethvalue(o, x) (from lobject.h), parameter L deleted
-- * luaK:setsvalue(o, x) (from lobject.h), parameter L deleted
-- * luaK:numadd, luaK:numsub, luaK:nummul, luaK:numdiv, luaK:nummod,
--   luaK:numpow, luaK:numunm, luaK:numisnan (from luaconf.h)
-- * copyexp(e1, e2) added in luaK:posfix to copy expdesc struct
--
-- Changed in 5.1.x:
-- * enum BinOpr has a new entry, OPR_MOD
-- * enum UnOpr has a new entry, OPR_LEN
-- * binopistest, unused in 5.0.x, has been deleted
-- * macro setmultret is new
-- * functions isnumeral, luaK_ret, boolK are new
-- * funcion nilK was named nil_constant in 5.0.x
-- * function interface changed: need_value, patchtestreg, concat
-- * TObject now a TValue
-- * functions luaK_setreturns, luaK_setoneret are new
-- * function luaK:setcallreturns deleted, to be replaced by:
--   luaK:setmultret, luaK:ret, luaK:setreturns, luaK:setoneret
-- * functions constfolding, codearith, codecomp are new
-- * luaK:codebinop has been deleted
-- * function luaK_setlist is new
-- * OPR_MULT renamed to OPR_MUL
----------------------------------------------------------------------]]

	-- requires luaP, luaX, luaY

	local luaYY = luaY
	local luaK = {}

--[[--------------------------------------------------------------------

  lopcodes.lua
  Lua 5 virtual machine opcodes in Lua
  This file is part of Yueliang.

  Copyright (c) 2006 Kein-Hong Man <khman@users.sf.net>
  The COPYRIGHT file describes the conditions
  under which this software may be distributed.

  See the ChangeLog for more information.

----------------------------------------------------------------------]]

--[[--------------------------------------------------------------------
-- Notes:
-- * an Instruction is a table with OP, A, B, C, Bx elements; this
--   makes the code easy to follow and should allow instruction handling
--   to work with doubles and ints
-- * WARNING luaP:Instruction outputs instructions encoded in little-
--   endian form and field size and positions are hard-coded
--
-- Not implemented:
-- *
--
-- Added:
-- * luaP:CREATE_Inst(c): create an inst from a number (for OP_SETLIST)
-- * luaP:Instruction(i): convert field elements to a 4-char string
-- * luaP:DecodeInst(x): convert 4-char string into field elements
--
-- Changed in 5.1.x:
-- * POS_OP added, instruction field positions changed
-- * some symbol names may have changed, e.g. LUAI_BITSINT
-- * new operators for RK indices: BITRK, ISK(x), INDEXK(r), RKASK(x)
-- * OP_MOD, OP_LEN is new
-- * OP_TEST is now OP_TESTSET, OP_TEST is new
-- * OP_FORLOOP, OP_TFORLOOP adjusted, OP_FORPREP is new
-- * OP_TFORPREP deleted
-- * OP_SETLIST and OP_SETLISTO merged and extended
-- * OP_VARARG is new
-- * many changes to implementation of OpMode data
----------------------------------------------------------------------]]

	local luaP = {}

--[[
===========================================================================
  We assume that instructions are unsigned numbers.
  All instructions have an opcode in the first 6 bits.
  Instructions can have the following fields:
        'A' : 8 bits
        'B' : 9 bits
        'C' : 9 bits
        'Bx' : 18 bits ('B' and 'C' together)
        'sBx' : signed Bx

  A signed argument is represented in excess K; that is, the number
  value is the unsigned value minus K. K is exactly the maximum value
  for that argument (so that -max is represented by 0, and +max is
  represented by 2*max), which is half the maximum for the corresponding
  unsigned argument.
===========================================================================
--]]

	luaP.OpMode = { iABC = 0, iABx = 1, iAsBx = 2 }  -- basic instruction format

	------------------------------------------------------------------------
	-- size and position of opcode arguments.
	-- * WARNING size and position is hard-coded elsewhere in this script
	------------------------------------------------------------------------
	luaP.SIZE_C  = 9
	luaP.SIZE_B  = 9
	luaP.SIZE_Bx = luaP.SIZE_C + luaP.SIZE_B
	luaP.SIZE_A  = 8

	luaP.SIZE_OP = 6

	luaP.POS_OP = 0
	luaP.POS_A  = luaP.POS_OP + luaP.SIZE_OP
	luaP.POS_C  = luaP.POS_A + luaP.SIZE_A
	luaP.POS_B  = luaP.POS_C + luaP.SIZE_C
	luaP.POS_Bx = luaP.POS_C

	------------------------------------------------------------------------
	-- limits for opcode arguments.
	-- we use (signed) int to manipulate most arguments,
	-- so they must fit in LUAI_BITSINT-1 bits (-1 for sign)
	------------------------------------------------------------------------
	-- removed "#if SIZE_Bx < BITS_INT-1" test, assume this script is
	-- running on a Lua VM with double or int as LUA_NUMBER

	luaP.MAXARG_Bx  = math.ldexp(1, luaP.SIZE_Bx) - 1
	luaP.MAXARG_sBx = math.floor(luaP.MAXARG_Bx / 2)  -- 'sBx' is signed

	luaP.MAXARG_A = math.ldexp(1, luaP.SIZE_A) - 1
	luaP.MAXARG_B = math.ldexp(1, luaP.SIZE_B) - 1
	luaP.MAXARG_C = math.ldexp(1, luaP.SIZE_C) - 1

	-- creates a mask with 'n' 1 bits at position 'p'
	-- MASK1(n,p) deleted, not required
	-- creates a mask with 'n' 0 bits at position 'p'
	-- MASK0(n,p) deleted, not required

--[[--------------------------------------------------------------------
  Visual representation for reference:

   31    |    |     |            0      bit position
    +-----+-----+-----+----------+
    |  B  |  C  |  A  |  Opcode  |      iABC format
    +-----+-----+-----+----------+
    -  9  -  9  -  8  -    6     -      field sizes
    +-----+-----+-----+----------+
    |   [s]Bx   |  A  |  Opcode  |      iABx | iAsBx format
    +-----+-----+-----+----------+

----------------------------------------------------------------------]]

	------------------------------------------------------------------------
	-- the following macros help to manipulate instructions
	-- * changed to a table object representation, very clean compared to
	--   the [nightmare] alternatives of using a number or a string
	-- * Bx is a separate element from B and C, since there is never a need
	--   to split Bx in the parser or code generator
	------------------------------------------------------------------------

	-- these accept or return opcodes in the form of string names
	function luaP:GET_OPCODE(i) return self.ROpCode[i.OP] end
	function luaP:SET_OPCODE(i, o) i.OP = self.OpCode[o] end

	function luaP:GETARG_A(i) return i.A end
	function luaP:SETARG_A(i, u) i.A = u end

	function luaP:GETARG_B(i) return i.B end
	function luaP:SETARG_B(i, b) i.B = b end

	function luaP:GETARG_C(i) return i.C end
	function luaP:SETARG_C(i, b) i.C = b end

	function luaP:GETARG_Bx(i) return i.Bx end
	function luaP:SETARG_Bx(i, b) i.Bx = b end

	function luaP:GETARG_sBx(i) return i.Bx - self.MAXARG_sBx end
	function luaP:SETARG_sBx(i, b) i.Bx = b + self.MAXARG_sBx end

	function luaP:CREATE_ABC(o,a,b,c)
		return {OP = self.OpCode[o], A = a, B = b, C = c}
	end

	function luaP:CREATE_ABx(o,a,bc)
		return {OP = self.OpCode[o], A = a, Bx = bc}
	end

	------------------------------------------------------------------------
	-- create an instruction from a number (for OP_SETLIST)
	------------------------------------------------------------------------
	function luaP:CREATE_Inst(c)
		local o = c % 64
		c = (c - o) / 64
		local a = c % 256
		c = (c - a) / 256
		return self:CREATE_ABx(o, a, c)
	end

	------------------------------------------------------------------------
	-- returns a 4-char string little-endian encoded form of an instruction
	------------------------------------------------------------------------
	function luaP:Instruction(i)
		if i.Bx then
			-- change to OP/A/B/C format
			i.C = i.Bx % 512
			i.B = (i.Bx - i.C) / 512
		end
		local I = i.A * 64 + i.OP
		local c0 = I % 256
		I = i.C * 64 + (I - c0) / 256  -- 6 bits of A left
		local c1 = I % 256
		I = i.B * 128 + (I - c1) / 256  -- 7 bits of C left
		local c2 = I % 256
		local c3 = (I - c2) / 256
		return string.char(c0, c1, c2, c3)
	end

	------------------------------------------------------------------------
	-- decodes a 4-char little-endian string into an instruction struct
	------------------------------------------------------------------------
	function luaP:DecodeInst(x)
		local byte = string.byte
		local i = {}
		local I = byte(x, 1)
		local op = I % 64
		i.OP = op
		I = byte(x, 2) * 4 + (I - op) / 64  -- 2 bits of c0 left
		local a = I % 256
		i.A = a
		I = byte(x, 3) * 4 + (I - a) / 256  -- 2 bits of c1 left
		local c = I % 512
		i.C = c
		i.B = byte(x, 4) * 2 + (I - c) / 512 -- 1 bits of c2 left
		local opmode = self.OpMode[tonumber(string.sub(self.opmodes[op + 1], 7, 7))]
		if opmode ~= "iABC" then
			i.Bx = i.B * 512 + i.C
		end
		return i
	end

	------------------------------------------------------------------------
	-- Macros to operate RK indices
	-- * these use arithmetic instead of bit ops
	------------------------------------------------------------------------

	-- this bit 1 means constant (0 means register)
	luaP.BITRK = math.ldexp(1, luaP.SIZE_B - 1)

	-- test whether value is a constant
	function luaP:ISK(x) return x >= self.BITRK end

	-- gets the index of the constant
	function luaP:INDEXK(x) return x - self.BITRK end

	luaP.MAXINDEXRK = luaP.BITRK - 1

	-- code a constant index as a RK value
	function luaP:RKASK(x) return x + self.BITRK end

	------------------------------------------------------------------------
	-- invalid register that fits in 8 bits
	------------------------------------------------------------------------
	luaP.NO_REG = luaP.MAXARG_A

	------------------------------------------------------------------------
	-- R(x) - register
	-- Kst(x) - constant (in constant table)
	-- RK(x) == if ISK(x) then Kst(INDEXK(x)) else R(x)
	------------------------------------------------------------------------

	------------------------------------------------------------------------
	-- grep "ORDER OP" if you change these enums
	------------------------------------------------------------------------

--[[--------------------------------------------------------------------
Lua virtual machine opcodes (enum OpCode):
------------------------------------------------------------------------
name          args    description
------------------------------------------------------------------------
OP_MOVE       A B     R(A) := R(B)
OP_LOADK      A Bx    R(A) := Kst(Bx)
OP_LOADBOOL   A B C   R(A) := (Bool)B; if (C) pc++
OP_LOADNIL    A B     R(A) := ... := R(B) := nil
OP_GETUPVAL   A B     R(A) := UpValue[B]
OP_GETGLOBAL  A Bx    R(A) := Gbl[Kst(Bx)]
OP_GETTABLE   A B C   R(A) := R(B)[RK(C)]
OP_SETGLOBAL  A Bx    Gbl[Kst(Bx)] := R(A)
OP_SETUPVAL   A B     UpValue[B] := R(A)
OP_SETTABLE   A B C   R(A)[RK(B)] := RK(C)
OP_NEWTABLE   A B C   R(A) := {} (size = B,C)
OP_SELF       A B C   R(A+1) := R(B); R(A) := R(B)[RK(C)]
OP_ADD        A B C   R(A) := RK(B) + RK(C)
OP_SUB        A B C   R(A) := RK(B) - RK(C)
OP_MUL        A B C   R(A) := RK(B) * RK(C)
OP_DIV        A B C   R(A) := RK(B) / RK(C)
OP_MOD        A B C   R(A) := RK(B) % RK(C)
OP_POW        A B C   R(A) := RK(B) ^ RK(C)
OP_UNM        A B     R(A) := -R(B)
OP_NOT        A B     R(A) := not R(B)
OP_LEN        A B     R(A) := length of R(B)
OP_CONCAT     A B C   R(A) := R(B).. ... ..R(C)
OP_JMP        sBx     pc+=sBx
OP_EQ         A B C   if ((RK(B) == RK(C)) ~= A) then pc++
OP_LT         A B C   if ((RK(B) <  RK(C)) ~= A) then pc++
OP_LE         A B C   if ((RK(B) <= RK(C)) ~= A) then pc++
OP_TEST       A C     if not (R(A) <=> C) then pc++
OP_TESTSET    A B C   if (R(B) <=> C) then R(A) := R(B) else pc++
OP_CALL       A B C   R(A), ... ,R(A+C-2) := R(A)(R(A+1), ... ,R(A+B-1))
OP_TAILCALL   A B C   return R(A)(R(A+1), ... ,R(A+B-1))
OP_RETURN     A B     return R(A), ... ,R(A+B-2)  (see note)
OP_FORLOOP    A sBx   R(A)+=R(A+2);
                      if R(A) <?= R(A+1) then { pc+=sBx; R(A+3)=R(A) }
OP_FORPREP    A sBx   R(A)-=R(A+2); pc+=sBx
OP_TFORLOOP   A C     R(A+3), ... ,R(A+2+C) := R(A)(R(A+1), R(A+2));
                      if R(A+3) ~= nil then R(A+2)=R(A+3) else pc++
OP_SETLIST    A B C   R(A)[(C-1)*FPF+i] := R(A+i), 1 <= i <= B
OP_CLOSE      A       close all variables in the stack up to (>=) R(A)
OP_CLOSURE    A Bx    R(A) := closure(KPROTO[Bx], R(A), ... ,R(A+n))
OP_VARARG     A B     R(A), R(A+1), ..., R(A+B-1) = vararg
----------------------------------------------------------------------]]

	luaP.opnames = {}  -- opcode names
	luaP.OpCode = {}   -- lookup name -> number
	luaP.ROpCode = {}  -- lookup number -> name

	------------------------------------------------------------------------
	-- ORDER OP
	------------------------------------------------------------------------
	local i = 0
	for v in string.gmatch([[
MOVE LOADK LOADBOOL LOADNIL GETUPVAL
GETGLOBAL GETTABLE SETGLOBAL SETUPVAL SETTABLE
NEWTABLE SELF ADD SUB MUL
DIV MOD POW UNM NOT
LEN CONCAT JMP EQ LT
LE TEST TESTSET CALL TAILCALL
RETURN FORLOOP FORPREP TFORLOOP SETLIST
CLOSE CLOSURE VARARG
]], "%S+") do
		local n = "OP_"..v
		luaP.opnames[i] = v
		luaP.OpCode[n] = i
		luaP.ROpCode[i] = n
		i = i + 1
	end
	luaP.NUM_OPCODES = i

--[[
===========================================================================
  Notes:
  (*) In OP_CALL, if (B == 0) then B = top. C is the number of returns - 1,
      and can be 0: OP_CALL then sets 'top' to last_result+1, so
      next open instruction (OP_CALL, OP_RETURN, OP_SETLIST) may use 'top'.
  (*) In OP_VARARG, if (B == 0) then use actual number of varargs and
      set top (like in OP_CALL with C == 0).
  (*) In OP_RETURN, if (B == 0) then return up to 'top'
  (*) In OP_SETLIST, if (B == 0) then B = 'top';
      if (C == 0) then next 'instruction' is real C
  (*) For comparisons, A specifies what condition the test should accept
      (true or false).
  (*) All 'skips' (pc++) assume that next instruction is a jump
===========================================================================
--]]

--[[--------------------------------------------------------------------
  masks for instruction properties. The format is:
  bits 0-1: op mode
  bits 2-3: C arg mode
  bits 4-5: B arg mode
  bit 6: instruction set register A
  bit 7: operator is a test

  for OpArgMask:
  OpArgN - argument is not used
  OpArgU - argument is used
  OpArgR - argument is a register or a jump offset
  OpArgK - argument is a constant or register/constant
----------------------------------------------------------------------]]

	-- was enum OpArgMask
	luaP.OpArgMask = { OpArgN = 0, OpArgU = 1, OpArgR = 2, OpArgK = 3 }

	------------------------------------------------------------------------
	-- e.g. to compare with symbols, luaP:getOpMode(...) == luaP.OpCode.iABC
	-- * accepts opcode parameter as strings, e.g. "OP_MOVE"
	------------------------------------------------------------------------

	function luaP:getOpMode(m)
		return self.opmodes[self.OpCode[m]] % 4
	end

	function luaP:getBMode(m)
		return math.floor(self.opmodes[self.OpCode[m]] / 16) % 4
	end

	function luaP:getCMode(m)
		return math.floor(self.opmodes[self.OpCode[m]] / 4) % 4
	end

	function luaP:testAMode(m)
		return math.floor(self.opmodes[self.OpCode[m]] / 64) % 2
	end

	function luaP:testTMode(m)
		return math.floor(self.opmodes[self.OpCode[m]] / 128)
	end

	-- luaP_opnames[] is set above, as the luaP.opnames table

	-- number of list items to accumulate before a SETLIST instruction
	luaP.LFIELDS_PER_FLUSH = 50

	------------------------------------------------------------------------
	-- build instruction properties array
	-- * deliberately coded to look like the C equivalent
	------------------------------------------------------------------------
	local function opmode(t, a, b, c, m)
		local luaP = luaP
		return t * 128 + a * 64 +
			luaP.OpArgMask[b] * 16 + luaP.OpArgMask[c] * 4 + luaP.OpMode[m]
	end

	-- ORDER OP
	luaP.opmodes = {
		-- T A B C mode opcode
		opmode(0, 1, "OpArgK", "OpArgN", "iABx"),     -- OP_LOADK
		opmode(0, 1, "OpArgU", "OpArgU", "iABC"),     -- OP_LOADBOOL
		opmode(0, 1, "OpArgR", "OpArgN", "iABC"),     -- OP_LOADNIL
		opmode(0, 1, "OpArgU", "OpArgN", "iABC"),     -- OP_GETUPVAL
		opmode(0, 1, "OpArgK", "OpArgN", "iABx"),     -- OP_GETGLOBAL
		opmode(0, 1, "OpArgR", "OpArgK", "iABC"),     -- OP_GETTABLE
		opmode(0, 0, "OpArgK", "OpArgN", "iABx"),     -- OP_SETGLOBAL
		opmode(0, 0, "OpArgU", "OpArgN", "iABC"),     -- OP_SETUPVAL
		opmode(0, 0, "OpArgK", "OpArgK", "iABC"),     -- OP_SETTABLE
		opmode(0, 1, "OpArgU", "OpArgU", "iABC"),     -- OP_NEWTABLE
		opmode(0, 1, "OpArgR", "OpArgK", "iABC"),     -- OP_SELF
		opmode(0, 1, "OpArgK", "OpArgK", "iABC"),     -- OP_ADD
		opmode(0, 1, "OpArgK", "OpArgK", "iABC"),     -- OP_SUB
		opmode(0, 1, "OpArgK", "OpArgK", "iABC"),     -- OP_MUL
		opmode(0, 1, "OpArgK", "OpArgK", "iABC"),     -- OP_DIV
		opmode(0, 1, "OpArgK", "OpArgK", "iABC"),     -- OP_MOD
		opmode(0, 1, "OpArgK", "OpArgK", "iABC"),     -- OP_POW
		opmode(0, 1, "OpArgR", "OpArgN", "iABC"),     -- OP_UNM
		opmode(0, 1, "OpArgR", "OpArgN", "iABC"),     -- OP_NOT
		opmode(0, 1, "OpArgR", "OpArgN", "iABC"),     -- OP_LEN
		opmode(0, 1, "OpArgR", "OpArgR", "iABC"),     -- OP_CONCAT
		opmode(0, 0, "OpArgR", "OpArgN", "iAsBx"),    -- OP_JMP
		opmode(1, 0, "OpArgK", "OpArgK", "iABC"),     -- OP_EQ
		opmode(1, 0, "OpArgK", "OpArgK", "iABC"),     -- OP_LT
		opmode(1, 0, "OpArgK", "OpArgK", "iABC"),     -- OP_LE
		opmode(1, 1, "OpArgR", "OpArgU", "iABC"),     -- OP_TEST
		opmode(1, 1, "OpArgR", "OpArgU", "iABC"),     -- OP_TESTSET
		opmode(0, 1, "OpArgU", "OpArgU", "iABC"),     -- OP_CALL
		opmode(0, 1, "OpArgU", "OpArgU", "iABC"),     -- OP_TAILCALL
		opmode(0, 0, "OpArgU", "OpArgN", "iABC"),     -- OP_RETURN
		opmode(0, 1, "OpArgR", "OpArgN", "iAsBx"),    -- OP_FORLOOP
		opmode(0, 1, "OpArgR", "OpArgN", "iAsBx"),    -- OP_FORPREP
		opmode(1, 0, "OpArgN", "OpArgU", "iABC"),     -- OP_TFORLOOP
		opmode(0, 0, "OpArgU", "OpArgU", "iABC"),     -- OP_SETLIST
		opmode(0, 0, "OpArgN", "OpArgN", "iABC"),     -- OP_CLOSE
		opmode(0, 1, "OpArgU", "OpArgN", "iABx"),     -- OP_CLOSURE
		opmode(0, 1, "OpArgU", "OpArgN", "iABC"),     -- OP_VARARG
	}
	-- an awkward way to set a zero-indexed table...
	luaP.opmodes[0] =
		opmode(0, 1, "OpArgR", "OpArgN", "iABC")      -- OP_MOVE

	------------------------------------------------------------------------
	-- constants used by code generator
	------------------------------------------------------------------------
	-- maximum stack for a Lua function
	luaK.MAXSTACK = 250  -- (from llimits.h)

--[[--------------------------------------------------------------------
-- other functions
----------------------------------------------------------------------]]

	------------------------------------------------------------------------
	-- emulation of TValue macros (these are from lobject.h)
	-- * TValue is a table since lcode passes references around
	-- * tt member field removed, using Lua's type() instead
	-- * for setsvalue, sethvalue, parameter L (deleted here) in lobject.h
	--   is used in an assert for testing, see checkliveness(g,obj)
	------------------------------------------------------------------------
	function luaK:ttisnumber(o)
		if o then return type(o.value) == "number" else return false end
	end
	function luaK:nvalue(o) return o.value end
	function luaK:setnilvalue(o) o.value = nil end
	function luaK:setsvalue(o, x) o.value = x end
	luaK.setnvalue = luaK.setsvalue
	luaK.sethvalue = luaK.setsvalue
	luaK.setbvalue = luaK.setsvalue

	------------------------------------------------------------------------
	-- The luai_num* macros define the primitive operations over numbers.
	-- * this is not the entire set of primitive operations from luaconf.h
	-- * used in luaK:constfolding()
	------------------------------------------------------------------------
	function luaK:numadd(a, b) return a + b end
	function luaK:numsub(a, b) return a - b end
	function luaK:nummul(a, b) return a * b end
	function luaK:numdiv(a, b) return a / b end
	function luaK:nummod(a, b) return a % b end
	-- ((a) - floor((a)/(b))*(b)) /* actual, for reference */
	function luaK:numpow(a, b) return a ^ b end
	function luaK:numunm(a) return -a end
	function luaK:numisnan(a) return not a == a end
	-- a NaN cannot equal another NaN

--[[--------------------------------------------------------------------
-- code generator functions
----------------------------------------------------------------------]]

	------------------------------------------------------------------------
	-- Marks the end of a patch list. It is an invalid value both as an absolute
	-- address, and as a list link (would link an element to itself).
	------------------------------------------------------------------------
	luaK.NO_JUMP = -1

	------------------------------------------------------------------------
	-- grep "ORDER OPR" if you change these enums
	------------------------------------------------------------------------
	luaK.BinOpr = {
		OPR_ADD = 0, OPR_SUB = 1, OPR_MUL = 2, OPR_DIV = 3, OPR_MOD = 4, OPR_POW = 5,
		OPR_CONCAT = 6,
		OPR_NE = 7, OPR_EQ = 8,
		OPR_LT = 9, OPR_LE = 10, OPR_GT = 11, OPR_GE = 12,
		OPR_AND = 13, OPR_OR = 14,
		OPR_NOBINOPR = 15,
	}

	-- * UnOpr is used by luaK:prefix's op argument, but not directly used
	--   because the function receives the symbols as strings, e.g. "OPR_NOT"
	luaK.UnOpr = {
		OPR_MINUS = 0, OPR_NOT = 1, OPR_LEN = 2, OPR_NOUNOPR = 3
	}

	------------------------------------------------------------------------
	-- returns the instruction object for given e (expdesc), was a macro
	------------------------------------------------------------------------
	function luaK:getcode(fs, e)
		return fs.f.code[e.info]
	end

	------------------------------------------------------------------------
	-- codes an instruction with a signed Bx (sBx) field, was a macro
	-- * used in luaK:jump(), (lparser) luaY:forbody()
	------------------------------------------------------------------------
	function luaK:codeAsBx(fs, o, A, sBx)
		return self:codeABx(fs, o, A, sBx + luaP.MAXARG_sBx)
	end

	------------------------------------------------------------------------
	-- set the expdesc e instruction for multiple returns, was a macro
	------------------------------------------------------------------------
	function luaK:setmultret(fs, e)
		self:setreturns(fs, e, luaYY.LUA_MULTRET)
	end

	------------------------------------------------------------------------
	-- there is a jump if patch lists are not identical, was a macro
	-- * used in luaK:exp2reg(), luaK:exp2anyreg(), luaK:exp2val()
	------------------------------------------------------------------------
	function luaK:hasjumps(e)
		return e.t ~= e.f
	end

	------------------------------------------------------------------------
	-- true if the expression is a constant number (for constant folding)
	-- * used in constfolding(), infix()
	------------------------------------------------------------------------
	function luaK:isnumeral(e)
		return e.k == "VKNUM" and e.t == self.NO_JUMP and e.f == self.NO_JUMP
	end

	------------------------------------------------------------------------
	-- codes loading of nil, optimization done if consecutive locations
	-- * used in luaK:discharge2reg(), (lparser) luaY:adjust_assign()
	------------------------------------------------------------------------
	function luaK:_nil(fs, from, n)
		if fs.pc > fs.lasttarget then  -- no jumps to current position?
			if fs.pc == 0 then  -- function start?
				if from >= fs.nactvar then
					return  -- positions are already clean
				end
			else
				local previous = fs.f.code[fs.pc - 1]
				if luaP:GET_OPCODE(previous) == "OP_LOADNIL" then
					local pfrom = luaP:GETARG_A(previous)
					local pto = luaP:GETARG_B(previous)
					if pfrom <= from and from <= pto + 1 then  -- can connect both?
						if from + n - 1 > pto then
							luaP:SETARG_B(previous, from + n - 1)
						end
						return
					end
				end
			end
		end
		self:codeABC(fs, "OP_LOADNIL", from, from + n - 1, 0)  -- else no optimization
	end

	------------------------------------------------------------------------
	--
	-- * used in multiple locations
	------------------------------------------------------------------------
	function luaK:jump(fs)
		local jpc = fs.jpc  -- save list of jumps to here
		fs.jpc = self.NO_JUMP
		local j = self:codeAsBx(fs, "OP_JMP", 0, self.NO_JUMP)
		j = self:concat(fs, j, jpc)  -- keep them on hold
		return j
	end

	------------------------------------------------------------------------
	-- codes a RETURN instruction
	-- * used in luaY:close_func(), luaY:retstat()
	------------------------------------------------------------------------
	function luaK:ret(fs, first, nret)
		self:codeABC(fs, "OP_RETURN", first, nret + 1, 0)
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:jumponcond(), luaK:codecomp()
	------------------------------------------------------------------------
	function luaK:condjump(fs, op, A, B, C)
		self:codeABC(fs, op, A, B, C)
		return self:jump(fs)
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:patchlistaux(), luaK:concat()
	------------------------------------------------------------------------
	function luaK:fixjump(fs, pc, dest)
		local jmp = fs.f.code[pc]
		local offset = dest - (pc + 1)
		assert(dest ~= self.NO_JUMP)
		if math.abs(offset) > luaP.MAXARG_sBx then
			luaX:syntaxerror(fs.ls, "control structure too long")
		end
		luaP:SETARG_sBx(jmp, offset)
	end

	------------------------------------------------------------------------
	-- returns current 'pc' and marks it as a jump target (to avoid wrong
	-- optimizations with consecutive instructions not in the same basic block).
	-- * used in multiple locations
	-- * fs.lasttarget tested only by luaK:_nil() when optimizing OP_LOADNIL
	------------------------------------------------------------------------
	function luaK:getlabel(fs)
		fs.lasttarget = fs.pc
		return fs.pc
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:need_value(), luaK:removevalues(), luaK:patchlistaux(),
	--   luaK:concat()
	------------------------------------------------------------------------
	function luaK:getjump(fs, pc)
		local offset = luaP:GETARG_sBx(fs.f.code[pc])
		if offset == self.NO_JUMP then  -- point to itself represents end of list
			return self.NO_JUMP  -- end of list
		else
			return (pc + 1) + offset  -- turn offset into absolute position
		end
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:need_value(), luaK:patchtestreg(), luaK:invertjump()
	------------------------------------------------------------------------
	function luaK:getjumpcontrol(fs, pc)
		local pi = fs.f.code[pc]
		local ppi = fs.f.code[pc - 1]
		if pc >= 1 and luaP:testTMode(luaP:GET_OPCODE(ppi)) ~= 0 then
			return ppi
		else
			return pi
		end
	end

	------------------------------------------------------------------------
	-- check whether list has any jump that do not produce a value
	-- (or produce an inverted value)
	-- * return value changed to boolean
	-- * used only in luaK:exp2reg()
	------------------------------------------------------------------------
	function luaK:need_value(fs, list)
		while list ~= self.NO_JUMP do
			local i = self:getjumpcontrol(fs, list)
			if luaP:GET_OPCODE(i) ~= "OP_TESTSET" then return true end
			list = self:getjump(fs, list)
		end
		return false  -- not found
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:removevalues(), luaK:patchlistaux()
	------------------------------------------------------------------------
	function luaK:patchtestreg(fs, node, reg)
		local i = self:getjumpcontrol(fs, node)
		if luaP:GET_OPCODE(i) ~= "OP_TESTSET" then
			return false  -- cannot patch other instructions
		end
		if reg ~= luaP.NO_REG and reg ~= luaP:GETARG_B(i) then
			luaP:SETARG_A(i, reg)
		else  -- no register to put value or register already has the value
			-- due to use of a table as i, i cannot be replaced by another table
			-- so the following is required; there is no change to ARG_C
			luaP:SET_OPCODE(i, "OP_TEST")
			local b = luaP:GETARG_B(i)
			luaP:SETARG_A(i, b)
			luaP:SETARG_B(i, 0)
			-- *i = CREATE_ABC(OP_TEST, GETARG_B(*i), 0, GETARG_C(*i)); /* C */
		end
		return true
	end

	------------------------------------------------------------------------
	--
	-- * used only in luaK:codenot()
	------------------------------------------------------------------------
	function luaK:removevalues(fs, list)
		while list ~= self.NO_JUMP do
			self:patchtestreg(fs, list, luaP.NO_REG)
			list = self:getjump(fs, list)
		end
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:dischargejpc(), luaK:patchlist(), luaK:exp2reg()
	------------------------------------------------------------------------
	function luaK:patchlistaux(fs, list, vtarget, reg, dtarget)
		while list ~= self.NO_JUMP do
			local _next = self:getjump(fs, list)
			if self:patchtestreg(fs, list, reg) then
				self:fixjump(fs, list, vtarget)
			else
				self:fixjump(fs, list, dtarget)  -- jump to default target
			end
			list = _next
		end
	end

	------------------------------------------------------------------------
	--
	-- * used only in luaK:code()
	------------------------------------------------------------------------
	function luaK:dischargejpc(fs)
		self:patchlistaux(fs, fs.jpc, fs.pc, luaP.NO_REG, fs.pc)
		fs.jpc = self.NO_JUMP
	end

	------------------------------------------------------------------------
	--
	-- * used in (lparser) luaY:whilestat(), luaY:repeatstat(), luaY:forbody()
	------------------------------------------------------------------------
	function luaK:patchlist(fs, list, target)
		if target == fs.pc then
			self:patchtohere(fs, list)
		else
			assert(target < fs.pc)
			self:patchlistaux(fs, list, target, luaP.NO_REG, target)
		end
	end

	------------------------------------------------------------------------
	--
	-- * used in multiple locations
	------------------------------------------------------------------------
	function luaK:patchtohere(fs, list)
		self:getlabel(fs)
		fs.jpc = self:concat(fs, fs.jpc, list)
	end

	------------------------------------------------------------------------
	-- * l1 was a pointer, now l1 is returned and callee assigns the value
	-- * used in multiple locations
	------------------------------------------------------------------------
	function luaK:concat(fs, l1, l2)
		if l2 == self.NO_JUMP then return l1
		elseif l1 == self.NO_JUMP then
			return l2
		else
			local list = l1
			local _next = self:getjump(fs, list)
			while _next ~= self.NO_JUMP do  -- find last element
				list = _next
				_next = self:getjump(fs, list)
			end
			self:fixjump(fs, list, l2)
		end
		return l1
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:reserveregs(), (lparser) luaY:forlist()
	------------------------------------------------------------------------
	function luaK:checkstack(fs, n)
		local newstack = fs.freereg + n
		if newstack > fs.f.maxstacksize then
			if newstack >= self.MAXSTACK then
				luaX:syntaxerror(fs.ls, "function or expression too complex")
			end
			fs.f.maxstacksize = newstack
		end
	end

	------------------------------------------------------------------------
	--
	-- * used in multiple locations
	------------------------------------------------------------------------
	function luaK:reserveregs(fs, n)
		self:checkstack(fs, n)
		fs.freereg = fs.freereg + n
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:freeexp(), luaK:dischargevars()
	------------------------------------------------------------------------
	function luaK:freereg(fs, reg)
		if not luaP:ISK(reg) and reg >= fs.nactvar then
			fs.freereg = fs.freereg - 1
			assert(reg == fs.freereg)
		end
	end

	------------------------------------------------------------------------
	--
	-- * used in multiple locations
	------------------------------------------------------------------------
	function luaK:freeexp(fs, e)
		if e.k == "VNONRELOC" then
			self:freereg(fs, e.info)
		end
	end

	------------------------------------------------------------------------
	-- * TODO NOTE implementation is not 100% correct, since the assert fails
	-- * luaH_set, setobj deleted; direct table access used instead
	-- * used in luaK:stringK(), luaK:numberK(), luaK:boolK(), luaK:nilK()
	------------------------------------------------------------------------
	function luaK:addk(fs, k, v)
		local L = fs.L
		local idx = fs.h[k.value]
		--TValue *idx = luaH_set(L, fs->h, k); /* C */
		local f = fs.f
		if self:ttisnumber(idx) then
			--TODO this assert currently FAILS (last tested for 5.0.2)
			--assert(fs.f.k[self:nvalue(idx)] == v)
			--assert(luaO_rawequalObj(&fs->f->k[cast_int(nvalue(idx))], v)); /* C */
			return self:nvalue(idx)
		else -- constant not found; create a new entry
			idx = {}
			self:setnvalue(idx, fs.nk)
			fs.h[k.value] = idx
			-- setnvalue(idx, cast_num(fs->nk)); /* C */
			luaYY:growvector(L, f.k, fs.nk, f.sizek, nil,
				luaP.MAXARG_Bx, "constant table overflow")
			-- loop to initialize empty f.k positions not required
			f.k[fs.nk] = v
			-- setobj(L, &f->k[fs->nk], v); /* C */
			-- luaC_barrier(L, f, v); /* GC */
			local nk = fs.nk
			fs.nk = fs.nk + 1
			return nk
		end

	end

	------------------------------------------------------------------------
	-- creates and sets a string object
	-- * used in (lparser) luaY:codestring(), luaY:singlevar()
	------------------------------------------------------------------------
	function luaK:stringK(fs, s)
		local o = {}  -- TValue
		self:setsvalue(o, s)
		return self:addk(fs, o, o)
	end

	------------------------------------------------------------------------
	-- creates and sets a number object
	-- * used in luaK:prefix() for negative (or negation of) numbers
	-- * used in (lparser) luaY:simpleexp(), luaY:fornum()
	------------------------------------------------------------------------
	function luaK:numberK(fs, r)
		local o = {}  -- TValue
		self:setnvalue(o, r)
		return self:addk(fs, o, o)
	end

	------------------------------------------------------------------------
	-- creates and sets a boolean object
	-- * used only in luaK:exp2RK()
	------------------------------------------------------------------------
	function luaK:boolK(fs, b)
		local o = {}  -- TValue
		self:setbvalue(o, b)
		return self:addk(fs, o, o)
	end

	------------------------------------------------------------------------
	-- creates and sets a nil object
	-- * used only in luaK:exp2RK()
	------------------------------------------------------------------------
	function luaK:nilK(fs)
		local k, v = {}, {}  -- TValue
		self:setnilvalue(v)
		-- cannot use nil as key; instead use table itself to represent nil
		self:sethvalue(k, fs.h)
		return self:addk(fs, k, v)
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:setmultret(), (lparser) luaY:adjust_assign()
	------------------------------------------------------------------------
	function luaK:setreturns(fs, e, nresults)
		if e.k == "VCALL" then  -- expression is an open function call?
			luaP:SETARG_C(self:getcode(fs, e), nresults + 1)
		elseif e.k == "VVARARG" then
			luaP:SETARG_B(self:getcode(fs, e), nresults + 1);
			luaP:SETARG_A(self:getcode(fs, e), fs.freereg);
			luaK:reserveregs(fs, 1)
		end
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:dischargevars(), (lparser) luaY:assignment()
	------------------------------------------------------------------------
	function luaK:setoneret(fs, e)
		if e.k == "VCALL" then  -- expression is an open function call?
			e.k = "VNONRELOC"
			e.info = luaP:GETARG_A(self:getcode(fs, e))
		elseif e.k == "VVARARG" then
			luaP:SETARG_B(self:getcode(fs, e), 2)
			e.k = "VRELOCABLE"  -- can relocate its simple result
		end
	end

	------------------------------------------------------------------------
	--
	-- * used in multiple locations
	------------------------------------------------------------------------
	function luaK:dischargevars(fs, e)
		local k = e.k
		if k == "VLOCAL" then
			e.k = "VNONRELOC"
		elseif k == "VUPVAL" then
			e.info = self:codeABC(fs, "OP_GETUPVAL", 0, e.info, 0)
			e.k = "VRELOCABLE"
		elseif k == "VGLOBAL" then
			e.info = self:codeABx(fs, "OP_GETGLOBAL", 0, e.info)
			e.k = "VRELOCABLE"
		elseif k == "VINDEXED" then
			self:freereg(fs, e.aux)
			self:freereg(fs, e.info)
			e.info = self:codeABC(fs, "OP_GETTABLE", 0, e.info, e.aux)
			e.k = "VRELOCABLE"
		elseif k == "VVARARG" or k == "VCALL" then
			self:setoneret(fs, e)
		else
			-- there is one value available (somewhere)
		end
	end

	------------------------------------------------------------------------
	--
	-- * used only in luaK:exp2reg()
	------------------------------------------------------------------------
	function luaK:code_label(fs, A, b, jump)
		self:getlabel(fs)  -- those instructions may be jump targets
		return self:codeABC(fs, "OP_LOADBOOL", A, b, jump)
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:discharge2anyreg(), luaK:exp2reg()
	------------------------------------------------------------------------
	function luaK:discharge2reg(fs, e, reg)
		self:dischargevars(fs, e)
		local k = e.k
		if k == "VNIL" then
			self:_nil(fs, reg, 1)
		elseif k == "VFALSE" or k == "VTRUE" then
			self:codeABC(fs, "OP_LOADBOOL", reg, (e.k == "VTRUE") and 1 or 0, 0)
		elseif k == "VK" then
			self:codeABx(fs, "OP_LOADK", reg, e.info)
		elseif k == "VKNUM" then
			self:codeABx(fs, "OP_LOADK", reg, self:numberK(fs, e.nval))
		elseif k == "VRELOCABLE" then
			local pc = self:getcode(fs, e)
			luaP:SETARG_A(pc, reg)
		elseif k == "VNONRELOC" then
			if reg ~= e.info then
				self:codeABC(fs, "OP_MOVE", reg, e.info, 0)
			end
		else
			assert(e.k == "VVOID" or e.k == "VJMP")
			return  -- nothing to do...
		end
		e.info = reg
		e.k = "VNONRELOC"
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:jumponcond(), luaK:codenot()
	------------------------------------------------------------------------
	function luaK:discharge2anyreg(fs, e)
		if e.k ~= "VNONRELOC" then
			self:reserveregs(fs, 1)
			self:discharge2reg(fs, e, fs.freereg - 1)
		end
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:exp2nextreg(), luaK:exp2anyreg(), luaK:storevar()
	------------------------------------------------------------------------
	function luaK:exp2reg(fs, e, reg)
		self:discharge2reg(fs, e, reg)
		if e.k == "VJMP" then
			e.t = self:concat(fs, e.t, e.info)  -- put this jump in 't' list
		end
		if self:hasjumps(e) then
			local final  -- position after whole expression
			local p_f = self.NO_JUMP  -- position of an eventual LOAD false
			local p_t = self.NO_JUMP  -- position of an eventual LOAD true
			if self:need_value(fs, e.t) or self:need_value(fs, e.f) then
				local fj = (e.k == "VJMP") and self.NO_JUMP or self:jump(fs)
				p_f = self:code_label(fs, reg, 0, 1)
				p_t = self:code_label(fs, reg, 1, 0)
				self:patchtohere(fs, fj)
			end
			final = self:getlabel(fs)
			self:patchlistaux(fs, e.f, final, reg, p_f)
			self:patchlistaux(fs, e.t, final, reg, p_t)
		end
		e.f, e.t = self.NO_JUMP, self.NO_JUMP
		e.info = reg
		e.k = "VNONRELOC"
	end

	------------------------------------------------------------------------
	--
	-- * used in multiple locations
	------------------------------------------------------------------------
	function luaK:exp2nextreg(fs, e)
		self:dischargevars(fs, e)
		self:freeexp(fs, e)
		self:reserveregs(fs, 1)
		self:exp2reg(fs, e, fs.freereg - 1)
	end

	------------------------------------------------------------------------
	--
	-- * used in multiple locations
	------------------------------------------------------------------------
	function luaK:exp2anyreg(fs, e)
		self:dischargevars(fs, e)
		if e.k == "VNONRELOC" then
			if not self:hasjumps(e) then  -- exp is already in a register
				return e.info
			end
			if e.info >= fs.nactvar then  -- reg. is not a local?
				self:exp2reg(fs, e, e.info)  -- put value on it
				return e.info
			end
		end
		self:exp2nextreg(fs, e)  -- default
		return e.info
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:exp2RK(), luaK:prefix(), luaK:posfix()
	-- * used in (lparser) luaY:yindex()
	------------------------------------------------------------------------
	function luaK:exp2val(fs, e)
		if self:hasjumps(e) then
			self:exp2anyreg(fs, e)
		else
			self:dischargevars(fs, e)
		end
	end

	------------------------------------------------------------------------
	--
	-- * used in multiple locations
	------------------------------------------------------------------------
	function luaK:exp2RK(fs, e)
		self:exp2val(fs, e)
		local k = e.k
		if k == "VKNUM" or k == "VTRUE" or k == "VFALSE" or k == "VNIL" then
			if fs.nk <= luaP.MAXINDEXRK then  -- constant fit in RK operand?
				-- converted from a 2-deep ternary operator expression
				if e.k == "VNIL" then
					e.info = self:nilK(fs)
				else
					e.info = (e.k == "VKNUM") and self:numberK(fs, e.nval)
						or self:boolK(fs, e.k == "VTRUE")
				end
				e.k = "VK"
				return luaP:RKASK(e.info)
			end
		elseif k == "VK" then
			if e.info <= luaP.MAXINDEXRK then  -- constant fit in argC?
				return luaP:RKASK(e.info)
			end
		else
			-- default
		end
		-- not a constant in the right range: put it in a register
		return self:exp2anyreg(fs, e)
	end

	------------------------------------------------------------------------
	--
	-- * used in (lparser) luaY:assignment(), luaY:localfunc(), luaY:funcstat()
	------------------------------------------------------------------------
	function luaK:storevar(fs, var, ex)
		local k = var.k
		if k == "VLOCAL" then
			self:freeexp(fs, ex)
			self:exp2reg(fs, ex, var.info)
			return
		elseif k == "VUPVAL" then
			local e = self:exp2anyreg(fs, ex)
			self:codeABC(fs, "OP_SETUPVAL", e, var.info, 0)
		elseif k == "VGLOBAL" then
			local e = self:exp2anyreg(fs, ex)
			self:codeABx(fs, "OP_SETGLOBAL", e, var.info)
		elseif k == "VINDEXED" then
			local e = self:exp2RK(fs, ex)
			self:codeABC(fs, "OP_SETTABLE", var.info, var.aux, e)
		else
			assert(0)  -- invalid var kind to store
		end
		self:freeexp(fs, ex)
	end

	------------------------------------------------------------------------
	--
	-- * used only in (lparser) luaY:primaryexp()
	------------------------------------------------------------------------
	function luaK:_self(fs, e, key)
		self:exp2anyreg(fs, e)
		self:freeexp(fs, e)
		local func = fs.freereg
		self:reserveregs(fs, 2)
		self:codeABC(fs, "OP_SELF", func, e.info, self:exp2RK(fs, key))
		self:freeexp(fs, key)
		e.info = func
		e.k = "VNONRELOC"
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:goiftrue(), luaK:codenot()
	------------------------------------------------------------------------
	function luaK:invertjump(fs, e)
		local pc = self:getjumpcontrol(fs, e.info)
		assert(luaP:testTMode(luaP:GET_OPCODE(pc)) ~= 0 and
			luaP:GET_OPCODE(pc) ~= "OP_TESTSET" and
			luaP:GET_OPCODE(pc) ~= "OP_TEST")
		luaP:SETARG_A(pc, (luaP:GETARG_A(pc) == 0) and 1 or 0)
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:goiftrue(), luaK:goiffalse()
	------------------------------------------------------------------------
	function luaK:jumponcond(fs, e, cond)
		if e.k == "VRELOCABLE" then
			local ie = self:getcode(fs, e)
			if luaP:GET_OPCODE(ie) == "OP_NOT" then
				fs.pc = fs.pc - 1  -- remove previous OP_NOT
				return self:condjump(fs, "OP_TEST", luaP:GETARG_B(ie), 0, cond and 0 or 1)
			end
			-- else go through
		end
		self:discharge2anyreg(fs, e)
		self:freeexp(fs, e)
		return self:condjump(fs, "OP_TESTSET", luaP.NO_REG, e.info, cond and 1 or 0)
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:infix(), (lparser) luaY:cond()
	------------------------------------------------------------------------
	function luaK:goiftrue(fs, e)
		local pc  -- pc of last jump
		self:dischargevars(fs, e)
		local k = e.k
		if k == "VK" or k == "VKNUM" or k == "VTRUE" then
			pc = self.NO_JUMP  -- always true; do nothing
		elseif k == "VFALSE" then
			pc = self:jump(fs)  -- always jump
		elseif k == "VJMP" then
			self:invertjump(fs, e)
			pc = e.info
		else
			pc = self:jumponcond(fs, e, false)
		end
		e.f = self:concat(fs, e.f, pc)  -- insert last jump in `f' list
		self:patchtohere(fs, e.t)
		e.t = self.NO_JUMP
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:infix()
	------------------------------------------------------------------------
	function luaK:goiffalse(fs, e)
		local pc  -- pc of last jump
		self:dischargevars(fs, e)
		local k = e.k
		if k == "VNIL" or k == "VFALSE"then
			pc = self.NO_JUMP  -- always false; do nothing
		elseif k == "VTRUE" then
			pc = self:jump(fs)  -- always jump
		elseif k == "VJMP" then
			pc = e.info
		else
			pc = self:jumponcond(fs, e, true)
		end
		e.t = self:concat(fs, e.t, pc)  -- insert last jump in `t' list
		self:patchtohere(fs, e.f)
		e.f = self.NO_JUMP
	end

	------------------------------------------------------------------------
	--
	-- * used only in luaK:prefix()
	------------------------------------------------------------------------
	function luaK:codenot(fs, e)
		self:dischargevars(fs, e)
		local k = e.k
		if k == "VNIL" or k == "VFALSE" then
			e.k = "VTRUE"
		elseif k == "VK" or k == "VKNUM" or k == "VTRUE" then
			e.k = "VFALSE"
		elseif k == "VJMP" then
			self:invertjump(fs, e)
		elseif k == "VRELOCABLE" or k == "VNONRELOC" then
			self:discharge2anyreg(fs, e)
			self:freeexp(fs, e)
			e.info = self:codeABC(fs, "OP_NOT", 0, e.info, 0)
			e.k = "VRELOCABLE"
		else
			assert(0)  -- cannot happen
		end
		-- interchange true and false lists
		e.f, e.t = e.t, e.f
		self:removevalues(fs, e.f)
		self:removevalues(fs, e.t)
	end

	------------------------------------------------------------------------
	--
	-- * used in (lparser) luaY:field(), luaY:primaryexp()
	------------------------------------------------------------------------
	function luaK:indexed(fs, t, k)
		t.aux = self:exp2RK(fs, k)
		t.k = "VINDEXED"
	end

	------------------------------------------------------------------------
	--
	-- * used only in luaK:codearith()
	------------------------------------------------------------------------
	function luaK:constfolding(op, e1, e2)
		local r
		if not self:isnumeral(e1) or not self:isnumeral(e2) then return false end
		local v1 = e1.nval
		local v2 = e2.nval
		if op == "OP_ADD" then
			r = self:numadd(v1, v2)
		elseif op == "OP_SUB" then
			r = self:numsub(v1, v2)
		elseif op == "OP_MUL" then
			r = self:nummul(v1, v2)
		elseif op == "OP_DIV" then
			if v2 == 0 then return false end  -- do not attempt to divide by 0
			r = self:numdiv(v1, v2)
		elseif op == "OP_MOD" then
			if v2 == 0 then return false end  -- do not attempt to divide by 0
			r = self:nummod(v1, v2)
		elseif op == "OP_POW" then
			r = self:numpow(v1, v2)
		elseif op == "OP_UNM" then
			r = self:numunm(v1)
		elseif op == "OP_LEN" then
			return false  -- no constant folding for 'len'
		else
			assert(0)
			r = 0
		end
		if self:numisnan(r) then return false end  -- do not attempt to produce NaN
		e1.nval = r
		return true
	end

	------------------------------------------------------------------------
	--
	-- * used in luaK:prefix(), luaK:posfix()
	------------------------------------------------------------------------
	function luaK:codearith(fs, op, e1, e2)
		if self:constfolding(op, e1, e2) then
			return
		else
			local o2 = (op ~= "OP_UNM" and op ~= "OP_LEN") and self:exp2RK(fs, e2) or 0
			local o1 = self:exp2RK(fs, e1)
			if o1 > o2 then
				self:freeexp(fs, e1)
				self:freeexp(fs, e2)
			else
				self:freeexp(fs, e2)
				self:freeexp(fs, e1)
			end
			e1.info = self:codeABC(fs, op, 0, o1, o2)
			e1.k = "VRELOCABLE"
		end
	end

	------------------------------------------------------------------------
	--
	-- * used only in luaK:posfix()
	------------------------------------------------------------------------
	function luaK:codecomp(fs, op, cond, e1, e2)
		local o1 = self:exp2RK(fs, e1)
		local o2 = self:exp2RK(fs, e2)
		self:freeexp(fs, e2)
		self:freeexp(fs, e1)
		if cond == 0 and op ~= "OP_EQ" then
			-- exchange args to replace by `<' or `<='
			o1, o2 = o2, o1  -- o1 <==> o2
			cond = 1
		end
		e1.info = self:condjump(fs, op, cond, o1, o2)
		e1.k = "VJMP"
	end

	------------------------------------------------------------------------
	--
	-- * used only in (lparser) luaY:subexpr()
	------------------------------------------------------------------------
	function luaK:prefix(fs, op, e)
		local e2 = {}  -- expdesc
		e2.t, e2.f = self.NO_JUMP, self.NO_JUMP
		e2.k = "VKNUM"
		e2.nval = 0
		if op == "OPR_MINUS" then
			if not self:isnumeral(e) then
				self:exp2anyreg(fs, e)  -- cannot operate on non-numeric constants
			end
			self:codearith(fs, "OP_UNM", e, e2)
		elseif op == "OPR_NOT" then
			self:codenot(fs, e)
		elseif op == "OPR_LEN" then
			self:exp2anyreg(fs, e)  -- cannot operate on constants
			self:codearith(fs, "OP_LEN", e, e2)
		else
			assert(0)
		end
	end

	------------------------------------------------------------------------
	--
	-- * used only in (lparser) luaY:subexpr()
	------------------------------------------------------------------------
	function luaK:infix(fs, op, v)
		if op == "OPR_AND" then
			self:goiftrue(fs, v)
		elseif op == "OPR_OR" then
			self:goiffalse(fs, v)
		elseif op == "OPR_CONCAT" then
			self:exp2nextreg(fs, v)  -- operand must be on the 'stack'
		elseif op == "OPR_ADD" or op == "OPR_SUB" or
			op == "OPR_MUL" or op == "OPR_DIV" or
			op == "OPR_MOD" or op == "OPR_POW" then
			if not self:isnumeral(v) then self:exp2RK(fs, v) end
		else
			self:exp2RK(fs, v)
		end
	end

	------------------------------------------------------------------------
	--
	-- * used only in (lparser) luaY:subexpr()
	------------------------------------------------------------------------
	-- table lookups to simplify testing
	luaK.arith_op = {
		OPR_ADD = "OP_ADD", OPR_SUB = "OP_SUB", OPR_MUL = "OP_MUL",
		OPR_DIV = "OP_DIV", OPR_MOD = "OP_MOD", OPR_POW = "OP_POW",
	}
	luaK.comp_op = {
		OPR_EQ = "OP_EQ", OPR_NE = "OP_EQ", OPR_LT = "OP_LT",
		OPR_LE = "OP_LE", OPR_GT = "OP_LT", OPR_GE = "OP_LE",
	}
	luaK.comp_cond = {
		OPR_EQ = 1, OPR_NE = 0, OPR_LT = 1,
		OPR_LE = 1, OPR_GT = 0, OPR_GE = 0,
	}
	function luaK:posfix(fs, op, e1, e2)
		-- needed because e1 = e2 doesn't copy values...
		-- * in 5.0.x, only k/info/aux/t/f copied, t for AND, f for OR
		--   but here, all elements are copied for completeness' sake
		local function copyexp(e1, e2)
			e1.k = e2.k
			e1.info = e2.info; e1.aux = e2.aux
			e1.nval = e2.nval
			e1.t = e2.t; e1.f = e2.f
		end
		if op == "OPR_AND" then
			assert(e1.t == self.NO_JUMP)  -- list must be closed
			self:dischargevars(fs, e2)
			e2.f = self:concat(fs, e2.f, e1.f)
			copyexp(e1, e2)
		elseif op == "OPR_OR" then
			assert(e1.f == self.NO_JUMP)  -- list must be closed
			self:dischargevars(fs, e2)
			e2.t = self:concat(fs, e2.t, e1.t)
			copyexp(e1, e2)
		elseif op == "OPR_CONCAT" then
			self:exp2val(fs, e2)
			if e2.k == "VRELOCABLE" and luaP:GET_OPCODE(self:getcode(fs, e2)) == "OP_CONCAT" then
				assert(e1.info == luaP:GETARG_B(self:getcode(fs, e2)) - 1)
				self:freeexp(fs, e1)
				luaP:SETARG_B(self:getcode(fs, e2), e1.info)
				e1.k = "VRELOCABLE"
				e1.info = e2.info
			else
				self:exp2nextreg(fs, e2)  -- operand must be on the 'stack'
				self:codearith(fs, "OP_CONCAT", e1, e2)
			end
		else
			-- the following uses a table lookup in place of conditionals
			local arith = self.arith_op[op]
			if arith then
				self:codearith(fs, arith, e1, e2)
			else
				local comp = self.comp_op[op]
				if comp then
					self:codecomp(fs, comp, self.comp_cond[op], e1, e2)
				else
					assert(0)
				end
			end--if arith
		end--if op
	end

	------------------------------------------------------------------------
	-- adjusts debug information for last instruction written, in order to
	-- change the line where item comes into existence
	-- * used in (lparser) luaY:funcargs(), luaY:forbody(), luaY:funcstat()
	------------------------------------------------------------------------
	function luaK:fixline(fs, line)
		fs.f.lineinfo[fs.pc - 1] = line
	end

	------------------------------------------------------------------------
	-- general function to write an instruction into the instruction buffer,
	-- sets debug information too
	-- * used in luaK:codeABC(), luaK:codeABx()
	-- * called directly by (lparser) luaY:whilestat()
	------------------------------------------------------------------------
	function luaK:code(fs, i, line)
		local f = fs.f
		self:dischargejpc(fs)  -- 'pc' will change
		-- put new instruction in code array
		luaYY:growvector(fs.L, f.code, fs.pc, f.sizecode, nil,
			luaYY.MAX_INT, "code size overflow")
		f.code[fs.pc] = i
		-- save corresponding line information
		luaYY:growvector(fs.L, f.lineinfo, fs.pc, f.sizelineinfo, nil,
			luaYY.MAX_INT, "code size overflow")
		f.lineinfo[fs.pc] = line
		local pc = fs.pc
		fs.pc = fs.pc + 1
		return pc
	end

	------------------------------------------------------------------------
	-- writes an instruction of type ABC
	-- * calls luaK:code()
	------------------------------------------------------------------------
	function luaK:codeABC(fs, o, a, b, c)
		assert(luaP:getOpMode(o) == luaP.OpMode.iABC)
		assert(luaP:getBMode(o) ~= luaP.OpArgMask.OpArgN or b == 0)
		assert(luaP:getCMode(o) ~= luaP.OpArgMask.OpArgN or c == 0)
		return self:code(fs, luaP:CREATE_ABC(o, a, b, c), fs.ls.lastline)
	end

	------------------------------------------------------------------------
	-- writes an instruction of type ABx
	-- * calls luaK:code(), called by luaK:codeAsBx()
	------------------------------------------------------------------------
	function luaK:codeABx(fs, o, a, bc)
		assert(luaP:getOpMode(o) == luaP.OpMode.iABx or
			luaP:getOpMode(o) == luaP.OpMode.iAsBx)
		assert(luaP:getCMode(o) == luaP.OpArgMask.OpArgN)
		return self:code(fs, luaP:CREATE_ABx(o, a, bc), fs.ls.lastline)
	end

	------------------------------------------------------------------------
	--
	-- * used in (lparser) luaY:closelistfield(), luaY:lastlistfield()
	------------------------------------------------------------------------
	function luaK:setlist(fs, base, nelems, tostore)
		local c = math.floor((nelems - 1)/luaP.LFIELDS_PER_FLUSH) + 1
		local b = (tostore == luaYY.LUA_MULTRET) and 0 or tostore
		assert(tostore ~= 0)
		if c <= luaP.MAXARG_C then
			self:codeABC(fs, "OP_SETLIST", base, b, c)
		else
			self:codeABC(fs, "OP_SETLIST", base, b, 0)
			self:code(fs, luaP:CREATE_Inst(c), fs.ls.lastline)
		end
		fs.freereg = base + 1  -- free registers with list values
	end

	local m = function(a) luaYY = a return luaK end
	local luaK = m(luaY)

--[[--------------------------------------------------------------------
-- Expression descriptor
-- * expkind changed to string constants; luaY:assignment was the only
--   function to use a relational operator with this enumeration
-- VVOID       -- no value
-- VNIL        -- no value
-- VTRUE       -- no value
-- VFALSE      -- no value
-- VK          -- info = index of constant in 'k'
-- VKNUM       -- nval = numerical value
-- VLOCAL      -- info = local register
-- VUPVAL,     -- info = index of upvalue in 'upvalues'
-- VGLOBAL     -- info = index of table; aux = index of global name in 'k'
-- VINDEXED    -- info = table register; aux = index register (or 'k')
-- VJMP        -- info = instruction pc
-- VRELOCABLE  -- info = instruction pc
-- VNONRELOC   -- info = result register
-- VCALL       -- info = instruction pc
-- VVARARG     -- info = instruction pc
} ----------------------------------------------------------------------]]

--[[--------------------------------------------------------------------
-- * expdesc in Lua 5.1.x has a union u and another struct s; this Lua
--   implementation ignores all instances of u and s usage
-- struct expdesc:
--   k  -- (enum: expkind)
--   info, aux -- (int, int)
--   nval -- (lua_Number)
--   t  -- patch list of 'exit when true'
--   f  -- patch list of 'exit when false'
----------------------------------------------------------------------]]

--[[--------------------------------------------------------------------
-- struct upvaldesc:
--   k  -- (lu_byte)
--   info -- (lu_byte)
----------------------------------------------------------------------]]

--[[--------------------------------------------------------------------
-- state needed to generate code for a given function
-- struct FuncState:
--   f  -- current function header (table: Proto)
--   h  -- table to find (and reuse) elements in 'k' (table: Table)
--   prev  -- enclosing function (table: FuncState)
--   ls  -- lexical state (table: LexState)
--   L  -- copy of the Lua state (table: lua_State)
--   bl  -- chain of current blocks (table: BlockCnt)
--   pc  -- next position to code (equivalent to 'ncode')
--   lasttarget   -- 'pc' of last 'jump target'
--   jpc  -- list of pending jumps to 'pc'
--   freereg  -- first free register
--   nk  -- number of elements in 'k'
--   np  -- number of elements in 'p'
--   nlocvars  -- number of elements in 'locvars'
--   nactvar  -- number of active local variables
--   upvalues[LUAI_MAXUPVALUES]  -- upvalues (table: upvaldesc)
--   actvar[LUAI_MAXVARS]  -- declared-variable stack
----------------------------------------------------------------------]]

	------------------------------------------------------------------------
	-- constants used by parser
	-- * picks up duplicate values from luaX if required
	------------------------------------------------------------------------

	luaY.LUA_QS = luaX.LUA_QS or "'%s'"  -- (from luaconf.h)

	luaY.SHRT_MAX = 32767 -- (from <limits.h>)
	luaY.LUAI_MAXVARS = 200  -- (luaconf.h)
	luaY.LUAI_MAXUPVALUES = 60  -- (luaconf.h)
	luaY.MAX_INT = luaX.MAX_INT or 2147483645  -- (from llimits.h)
	-- * INT_MAX-2 for 32-bit systems
	luaY.LUAI_MAXCCALLS = 200  -- (from luaconf.h)

	luaY.VARARG_HASARG = 1  -- (from lobject.h)
	-- NOTE: HASARG_MASK is value-specific
	luaY.HASARG_MASK = 2 -- this was added for a bitop in parlist()
	luaY.VARARG_ISVARARG = 2
	-- NOTE: there is some value-specific code that involves VARARG_NEEDSARG
	luaY.VARARG_NEEDSARG = 4

	luaY.LUA_MULTRET = -1  -- (lua.h)

--[[--------------------------------------------------------------------
-- other functions
----------------------------------------------------------------------]]

	------------------------------------------------------------------------
	-- LUA_QL describes how error messages quote program elements.
	-- CHANGE it if you want a different appearance. (from luaconf.h)
	------------------------------------------------------------------------
	function luaY:LUA_QL(x)
		return "'"..x.."'"
	end

	------------------------------------------------------------------------
	-- this is a stripped-down luaM_growvector (from lmem.h) which is a
	-- macro based on luaM_growaux (in lmem.c); all the following does is
	-- reproduce the size limit checking logic of the original function
	-- so that error behaviour is identical; all arguments preserved for
	-- convenience, even those which are unused
	-- * set the t field to nil, since this originally does a sizeof(t)
	-- * size (originally a pointer) is never updated, their final values
	--   are set by luaY:close_func(), so overall things should still work
	------------------------------------------------------------------------
	function luaY:growvector(L, v, nelems, size, t, limit, e)
		if nelems >= limit then
			error(e)  -- was luaG_runerror
		end
	end

	------------------------------------------------------------------------
	-- initialize a new function prototype structure (from lfunc.c)
	-- * used only in open_func()
	------------------------------------------------------------------------
	function luaY:newproto(L)
		local f = {} -- Proto
		-- luaC_link(L, obj2gco(f), LUA_TPROTO); /* GC */
		f.k = {}
		f.sizek = 0
		f.p = {}
		f.sizep = 0
		f.code = {}
		f.sizecode = 0
		f.sizelineinfo = 0
		f.sizeupvalues = 0
		f.nups = 0
		f.upvalues = {}
		f.numparams = 0
		f.is_vararg = 0
		f.maxstacksize = 0
		f.lineinfo = {}
		f.sizelocvars = 0
		f.locvars = {}
		f.lineDefined = 0
		f.lastlinedefined = 0
		f.source = nil
		return f
	end

	------------------------------------------------------------------------
	-- converts an integer to a "floating point byte", represented as
	-- (eeeeexxx), where the real value is (1xxx) * 2^(eeeee - 1) if
	-- eeeee != 0 and (xxx) otherwise.
	------------------------------------------------------------------------
	function luaY:int2fb(x)
		local e = 0  -- exponent
		while x >= 16 do
			x = math.floor((x + 1) / 2)
			e = e + 1
		end
		if x < 8 then
			return x
		else
			return ((e + 1) * 8) + (x - 8)
		end
	end

--[[--------------------------------------------------------------------
-- parser functions
----------------------------------------------------------------------]]

	------------------------------------------------------------------------
	-- true of the kind of expression produces multiple return values
	------------------------------------------------------------------------
	function luaY:hasmultret(k)
		return k == "VCALL" or k == "VVARARG"
	end

	------------------------------------------------------------------------
	-- convenience function to access active local i, returns entry
	------------------------------------------------------------------------
	function luaY:getlocvar(fs, i)
		return fs.f.locvars[ fs.actvar[i] ]
	end

	------------------------------------------------------------------------
	-- check a limit, string m provided as an error message
	------------------------------------------------------------------------
	function luaY:checklimit(fs, v, l, m)
		if v > l then self:errorlimit(fs, l, m) end
	end

--[[--------------------------------------------------------------------
-- nodes for block list (list of active blocks)
-- struct BlockCnt:
--   previous  -- chain (table: BlockCnt)
--   breaklist  -- list of jumps out of this loop
--   nactvar  -- # active local variables outside the breakable structure
--   upval  -- true if some variable in the block is an upvalue (boolean)
--   isbreakable  -- true if 'block' is a loop (boolean)
----------------------------------------------------------------------]]

	------------------------------------------------------------------------
	-- prototypes for recursive non-terminal functions
	------------------------------------------------------------------------
	-- prototypes deleted; not required in Lua

	------------------------------------------------------------------------
	-- reanchor if last token is has a constant string, see close_func()
	-- * used only in close_func()
	------------------------------------------------------------------------
	function luaY:anchor_token(ls)
		if ls.t.token == "TK_NAME" or ls.t.token == "TK_STRING" then
			-- not relevant to Lua implementation of parser
			-- local ts = ls.t.seminfo
			-- luaX_newstring(ls, getstr(ts), ts->tsv.len); /* C */
		end
	end

	------------------------------------------------------------------------
	-- throws a syntax error if token expected is not there
	------------------------------------------------------------------------
	function luaY:error_expected(ls, token)
		luaX:syntaxerror(ls,
			string.format(self.LUA_QS.." expected", luaX:token2str(ls, token)))
	end

	------------------------------------------------------------------------
	-- prepares error message for display, for limits exceeded
	-- * used only in checklimit()
	------------------------------------------------------------------------
	function luaY:errorlimit(fs, limit, what)
		local msg = (fs.f.linedefined == 0) and
			string.format("main function has more than %d %s", limit, what) or
			string.format("function at line %d has more than %d %s",
				fs.f.linedefined, limit, what)
		luaX:lexerror(fs.ls, msg, 0)
	end

	------------------------------------------------------------------------
	-- tests for a token, returns outcome
	-- * return value changed to boolean
	------------------------------------------------------------------------
	function luaY:testnext(ls, c)
		if ls.t.token == c then
			luaX:next(ls)
			return true
		else
			return false
		end
	end

	------------------------------------------------------------------------
	-- check for existence of a token, throws error if not found
	------------------------------------------------------------------------
	function luaY:check(ls, c)
		if ls.t.token ~= c then
			self:error_expected(ls, c)
		end
	end

	------------------------------------------------------------------------
	-- verify existence of a token, then skip it
	------------------------------------------------------------------------
	function luaY:checknext(ls, c)
		self:check(ls, c)
		luaX:next(ls)
	end

	------------------------------------------------------------------------
	-- throws error if condition not matched
	------------------------------------------------------------------------
	function luaY:check_condition(ls, c, msg)
		if not c then luaX:syntaxerror(ls, msg) end
	end

	------------------------------------------------------------------------
	-- verifies token conditions are met or else throw error
	------------------------------------------------------------------------
	function luaY:check_match(ls, what, who, where)
		if not self:testnext(ls, what) then
			if where == ls.linenumber then
				self:error_expected(ls, what)
			else
				luaX:syntaxerror(ls, string.format(
					self.LUA_QS.." expected (to close "..self.LUA_QS.." at line %d)",
					luaX:token2str(ls, what), luaX:token2str(ls, who), where))
			end
		end
	end

	------------------------------------------------------------------------
	-- expect that token is a name, return the name
	------------------------------------------------------------------------
	function luaY:str_checkname(ls)
		self:check(ls, "TK_NAME")
		local ts = ls.t.seminfo
		luaX:next(ls)
		return ts
	end

	------------------------------------------------------------------------
	-- initialize a struct expdesc, expression description data structure
	------------------------------------------------------------------------
	function luaY:init_exp(e, k, i)
		e.f, e.t = luaK.NO_JUMP, luaK.NO_JUMP
		e.k = k
		e.info = i
	end

	------------------------------------------------------------------------
	-- adds given string s in string pool, sets e as VK
	------------------------------------------------------------------------
	function luaY:codestring(ls, e, s)
		self:init_exp(e, "VK", luaK:stringK(ls.fs, s))
	end

	------------------------------------------------------------------------
	-- consume a name token, adds it to string pool, sets e as VK
	------------------------------------------------------------------------
	function luaY:checkname(ls, e)
		self:codestring(ls, e, self:str_checkname(ls))
	end

	------------------------------------------------------------------------
	-- creates struct entry for a local variable
	-- * used only in new_localvar()
	------------------------------------------------------------------------
	function luaY:registerlocalvar(ls, varname)
		local fs = ls.fs
		local f = fs.f
		self:growvector(ls.L, f.locvars, fs.nlocvars, f.sizelocvars,
			nil, self.SHRT_MAX, "too many local variables")
		-- loop to initialize empty f.locvar positions not required
		f.locvars[fs.nlocvars] = {} -- LocVar
		f.locvars[fs.nlocvars].varname = varname
		-- luaC_objbarrier(ls.L, f, varname) /* GC */
		local nlocvars = fs.nlocvars
		fs.nlocvars = fs.nlocvars + 1
		return nlocvars
	end

	------------------------------------------------------------------------
	-- creates a new local variable given a name and an offset from nactvar
	-- * used in fornum(), forlist(), parlist(), body()
	------------------------------------------------------------------------
	function luaY:new_localvarliteral(ls, v, n)
		self:new_localvar(ls, v, n)
	end

	------------------------------------------------------------------------
	-- register a local variable, set in active variable list
	------------------------------------------------------------------------
	function luaY:new_localvar(ls, name, n)
		local fs = ls.fs
		self:checklimit(fs, fs.nactvar + n + 1, self.LUAI_MAXVARS, "local variables")
		fs.actvar[fs.nactvar + n] = self:registerlocalvar(ls, name)
	end

	------------------------------------------------------------------------
	-- adds nvars number of new local variables, set debug information
	------------------------------------------------------------------------
	function luaY:adjustlocalvars(ls, nvars)
		local fs = ls.fs
		fs.nactvar = fs.nactvar + nvars
		for i = nvars, 1, -1 do
			self:getlocvar(fs, fs.nactvar - i).startpc = fs.pc
		end
	end

	------------------------------------------------------------------------
	-- removes a number of locals, set debug information
	------------------------------------------------------------------------
	function luaY:removevars(ls, tolevel)
		local fs = ls.fs
		while fs.nactvar > tolevel do
			fs.nactvar = fs.nactvar - 1
			self:getlocvar(fs, fs.nactvar).endpc = fs.pc
		end
	end

	------------------------------------------------------------------------
	-- returns an existing upvalue index based on the given name, or
	-- creates a new upvalue struct entry and returns the new index
	-- * used only in singlevaraux()
	------------------------------------------------------------------------
	function luaY:indexupvalue(fs, name, v)
		local f = fs.f
		for i = 0, f.nups - 1 do
			if fs.upvalues[i].k == v.k and fs.upvalues[i].info == v.info then
				assert(f.upvalues[i] == name)
				return i
			end
		end
		-- new one
		self:checklimit(fs, f.nups + 1, self.LUAI_MAXUPVALUES, "upvalues")
		self:growvector(fs.L, f.upvalues, f.nups, f.sizeupvalues,
			nil, self.MAX_INT, "")
		-- loop to initialize empty f.upvalues positions not required
		f.upvalues[f.nups] = name
		-- luaC_objbarrier(fs->L, f, name); /* GC */
		assert(v.k == "VLOCAL" or v.k == "VUPVAL")
		-- this is a partial copy; only k & info fields used
		fs.upvalues[f.nups] = { k = v.k, info = v.info }
		local nups = f.nups
		f.nups = f.nups + 1
		return nups
	end

	------------------------------------------------------------------------
	-- search the local variable namespace of the given fs for a match
	-- * used only in singlevaraux()
	------------------------------------------------------------------------
	function luaY:searchvar(fs, n)
		for i = fs.nactvar - 1, 0, -1 do
			if n == self:getlocvar(fs, i).varname then
				return i
			end
		end
		return -1  -- not found
	end

	------------------------------------------------------------------------
	-- * mark upvalue flags in function states up to a given level
	-- * used only in singlevaraux()
	------------------------------------------------------------------------
	function luaY:markupval(fs, level)
		local bl = fs.bl
		while bl and bl.nactvar > level do bl = bl.previous end
		if bl then bl.upval = true end
	end

	------------------------------------------------------------------------
	-- handle locals, globals and upvalues and related processing
	-- * search mechanism is recursive, calls itself to search parents
	-- * used only in singlevar()
	------------------------------------------------------------------------
	function luaY:singlevaraux(fs, n, var, base)
		if fs == nil then  -- no more levels?
			self:init_exp(var, "VGLOBAL", luaP.NO_REG)  -- default is global variable
			return "VGLOBAL"
		else
			local v = self:searchvar(fs, n)  -- look up at current level
			if v >= 0 then
				self:init_exp(var, "VLOCAL", v)
				if base == 0 then
					self:markupval(fs, v)  -- local will be used as an upval
				end
				return "VLOCAL"
			else  -- not found at current level; try upper one
				if self:singlevaraux(fs.prev, n, var, 0) == "VGLOBAL" then
					return "VGLOBAL"
				end
				var.info = self:indexupvalue(fs, n, var)  -- else was LOCAL or UPVAL
				var.k = "VUPVAL"  -- upvalue in this level
				return "VUPVAL"
			end--if v
		end--if fs
	end

	------------------------------------------------------------------------
	-- consume a name token, creates a variable (global|local|upvalue)
	-- * used in prefixexp(), funcname()
	------------------------------------------------------------------------
	function luaY:singlevar(ls, var)
		local varname = self:str_checkname(ls)
		local fs = ls.fs
		if self:singlevaraux(fs, varname, var, 1) == "VGLOBAL" then
			var.info = luaK:stringK(fs, varname)  -- info points to global name
		end
	end

	------------------------------------------------------------------------
	-- adjust RHS to match LHS in an assignment
	-- * used in assignment(), forlist(), localstat()
	------------------------------------------------------------------------
	function luaY:adjust_assign(ls, nvars, nexps, e)
		local fs = ls.fs
		local extra = nvars - nexps
		if self:hasmultret(e.k) then
			extra = extra + 1  -- includes call itself
			if extra <= 0 then extra = 0 end
			luaK:setreturns(fs, e, extra)  -- last exp. provides the difference
			if extra > 1 then luaK:reserveregs(fs, extra - 1) end
		else
			if e.k ~= "VVOID" then luaK:exp2nextreg(fs, e) end  -- close last expression
			if extra > 0 then
				local reg = fs.freereg
				luaK:reserveregs(fs, extra)
				luaK:_nil(fs, reg, extra)
			end
		end
	end

	------------------------------------------------------------------------
	-- tracks and limits parsing depth, assert check at end of parsing
	------------------------------------------------------------------------
	function luaY:enterlevel(ls)
		ls.L.nCcalls = ls.L.nCcalls + 1
		if ls.L.nCcalls > self.LUAI_MAXCCALLS then
			luaX:lexerror(ls, "chunk has too many syntax levels", 0)
		end
	end

	------------------------------------------------------------------------
	-- tracks parsing depth, a pair with luaY:enterlevel()
	------------------------------------------------------------------------
	function luaY:leavelevel(ls)
		ls.L.nCcalls = ls.L.nCcalls - 1
	end

	------------------------------------------------------------------------
	-- enters a code unit, initializes elements
	------------------------------------------------------------------------
	function luaY:enterblock(fs, bl, isbreakable)
		bl.breaklist = luaK.NO_JUMP
		bl.isbreakable = isbreakable
		bl.nactvar = fs.nactvar
		bl.upval = false
		bl.previous = fs.bl
		fs.bl = bl
		assert(fs.freereg == fs.nactvar)
	end

	------------------------------------------------------------------------
	-- leaves a code unit, close any upvalues
	------------------------------------------------------------------------
	function luaY:leaveblock(fs)
		local bl = fs.bl
		fs.bl = bl.previous
		self:removevars(fs.ls, bl.nactvar)
		if bl.upval then
			luaK:codeABC(fs, "OP_CLOSE", bl.nactvar, 0, 0)
		end
		-- a block either controls scope or breaks (never both)
		assert(not bl.isbreakable or not bl.upval)
		assert(bl.nactvar == fs.nactvar)
		fs.freereg = fs.nactvar  -- free registers
		luaK:patchtohere(fs, bl.breaklist)
	end

	------------------------------------------------------------------------
	-- implement the instantiation of a function prototype, append list of
	-- upvalues after the instantiation instruction
	-- * used only in body()
	------------------------------------------------------------------------
	function luaY:pushclosure(ls, func, v)
		local fs = ls.fs
		local f = fs.f
		self:growvector(ls.L, f.p, fs.np, f.sizep, nil,
			luaP.MAXARG_Bx, "constant table overflow")
		-- loop to initialize empty f.p positions not required
		f.p[fs.np] = func.f
		fs.np = fs.np + 1
		-- luaC_objbarrier(ls->L, f, func->f); /* C */
		self:init_exp(v, "VRELOCABLE", luaK:codeABx(fs, "OP_CLOSURE", 0, fs.np - 1))
		for i = 0, func.f.nups - 1 do
			local o = (func.upvalues[i].k == "VLOCAL") and "OP_MOVE" or "OP_GETUPVAL"
			luaK:codeABC(fs, o, 0, func.upvalues[i].info, 0)
		end
	end

	------------------------------------------------------------------------
	-- opening of a function
	------------------------------------------------------------------------
	function luaY:open_func(ls, fs)
		local L = ls.L
		local f = self:newproto(ls.L)
		fs.f = f
		fs.prev = ls.fs  -- linked list of funcstates
		fs.ls = ls
		fs.L = L
		ls.fs = fs
		fs.pc = 0
		fs.lasttarget = -1
		fs.jpc = luaK.NO_JUMP
		fs.freereg = 0
		fs.nk = 0
		fs.np = 0
		fs.nlocvars = 0
		fs.nactvar = 0
		fs.bl = nil
		f.source = ls.source
		f.maxstacksize = 2  -- registers 0/1 are always valid
		fs.h = {}  -- constant table; was luaH_new call
		-- anchor table of constants and prototype (to avoid being collected)
		-- sethvalue2s(L, L->top, fs->h); incr_top(L); /* C */
		-- setptvalue2s(L, L->top, f); incr_top(L);
	end

	------------------------------------------------------------------------
	-- closing of a function
	------------------------------------------------------------------------
	function luaY:close_func(ls)
		local L = ls.L
		local fs = ls.fs
		local f = fs.f
		self:removevars(ls, 0)
		luaK:ret(fs, 0, 0)  -- final return
		-- luaM_reallocvector deleted for f->code, f->lineinfo, f->k, f->p,
		-- f->locvars, f->upvalues; not required for Lua table arrays
		f.sizecode = fs.pc
		f.sizelineinfo = fs.pc
		f.sizek = fs.nk
		f.sizep = fs.np
		f.sizelocvars = fs.nlocvars
		f.sizeupvalues = f.nups
		--assert(luaG_checkcode(f))  -- currently not implemented
		assert(fs.bl == nil)
		ls.fs = fs.prev
		-- the following is not required for this implementation; kept here
		-- for completeness
		-- L->top -= 2;  /* remove table and prototype from the stack */
		-- last token read was anchored in defunct function; must reanchor it
		if fs then self:anchor_token(ls) end
	end

	------------------------------------------------------------------------
	-- parser initialization function
	-- * note additional sub-tables needed for LexState, FuncState
	------------------------------------------------------------------------
	function luaY:parser(L, z, buff, name)
		local lexstate = {}  -- LexState
		lexstate.t = {}
		lexstate.lookahead = {}
		local funcstate = {}  -- FuncState
		funcstate.upvalues = {}
		funcstate.actvar = {}
		-- the following nCcalls initialization added for convenience
		L.nCcalls = 0
		lexstate.buff = buff
		luaX:setinput(L, lexstate, z, name)
		self:open_func(lexstate, funcstate)
		funcstate.f.is_vararg = self.VARARG_ISVARARG  -- main func. is always vararg
		luaX:next(lexstate)  -- read first token
		self:chunk(lexstate)
		self:check(lexstate, "TK_EOS")
		self:close_func(lexstate)
		assert(funcstate.prev == nil)
		assert(funcstate.f.nups == 0)
		assert(lexstate.fs == nil)
		return funcstate.f
	end

--[[--------------------------------------------------------------------
-- GRAMMAR RULES
----------------------------------------------------------------------]]

	------------------------------------------------------------------------
	-- parse a function name suffix, for function call specifications
	-- * used in primaryexp(), funcname()
	------------------------------------------------------------------------
	function luaY:field(ls, v)
		-- field -> ['.' | ':'] NAME
		local fs = ls.fs
		local key = {}  -- expdesc
		luaK:exp2anyreg(fs, v)
		luaX:next(ls)  -- skip the dot or colon
		self:checkname(ls, key)
		luaK:indexed(fs, v, key)
	end

	------------------------------------------------------------------------
	-- parse a table indexing suffix, for constructors, expressions
	-- * used in recfield(), primaryexp()
	------------------------------------------------------------------------
	function luaY:yindex(ls, v)
		-- index -> '[' expr ']'
		luaX:next(ls)  -- skip the '['
		self:expr(ls, v)
		luaK:exp2val(ls.fs, v)
		self:checknext(ls, "]")
	end

--[[--------------------------------------------------------------------
-- Rules for Constructors
----------------------------------------------------------------------]]

--[[--------------------------------------------------------------------
-- struct ConsControl:
--   v  -- last list item read (table: struct expdesc)
--   t  -- table descriptor (table: struct expdesc)
--   nh  -- total number of 'record' elements
--   na  -- total number of array elements
--   tostore  -- number of array elements pending to be stored
----------------------------------------------------------------------]]

	------------------------------------------------------------------------
	-- parse a table record (hash) field
	-- * used in constructor()
	------------------------------------------------------------------------
	function luaY:recfield(ls, cc)
		-- recfield -> (NAME | '['exp1']') = exp1
		local fs = ls.fs
		local reg = ls.fs.freereg
		local key, val = {}, {}  -- expdesc
		if ls.t.token == "TK_NAME" then
			self:checklimit(fs, cc.nh, self.MAX_INT, "items in a constructor")
			self:checkname(ls, key)
		else  -- ls->t.token == '['
			self:yindex(ls, key)
		end
		cc.nh = cc.nh + 1
		self:checknext(ls, "=")
		local rkkey = luaK:exp2RK(fs, key)
		self:expr(ls, val)
		luaK:codeABC(fs, "OP_SETTABLE", cc.t.info, rkkey, luaK:exp2RK(fs, val))
		fs.freereg = reg  -- free registers
	end

	------------------------------------------------------------------------
	-- emit a set list instruction if enough elements (LFIELDS_PER_FLUSH)
	-- * used in constructor()
	------------------------------------------------------------------------
	function luaY:closelistfield(fs, cc)
		if cc.v.k == "VVOID" then return end  -- there is no list item
		luaK:exp2nextreg(fs, cc.v)
		cc.v.k = "VVOID"
		if cc.tostore == luaP.LFIELDS_PER_FLUSH then
			luaK:setlist(fs, cc.t.info, cc.na, cc.tostore)  -- flush
			cc.tostore = 0  -- no more items pending
		end
	end

	------------------------------------------------------------------------
	-- emit a set list instruction at the end of parsing list constructor
	-- * used in constructor()
	------------------------------------------------------------------------
	function luaY:lastlistfield(fs, cc)
		if cc.tostore == 0 then return end
		if self:hasmultret(cc.v.k) then
			luaK:setmultret(fs, cc.v)
			luaK:setlist(fs, cc.t.info, cc.na, self.LUA_MULTRET)
			cc.na = cc.na - 1  -- do not count last expression (unknown number of elements)
		else
			if cc.v.k ~= "VVOID" then
				luaK:exp2nextreg(fs, cc.v)
			end
			luaK:setlist(fs, cc.t.info, cc.na, cc.tostore)
		end
	end

	------------------------------------------------------------------------
	-- parse a table list (array) field
	-- * used in constructor()
	------------------------------------------------------------------------
	function luaY:listfield(ls, cc)
		self:expr(ls, cc.v)
		self:checklimit(ls.fs, cc.na, self.MAX_INT, "items in a constructor")
		cc.na = cc.na + 1
		cc.tostore = cc.tostore + 1
	end

	------------------------------------------------------------------------
	-- parse a table constructor
	-- * used in funcargs(), simpleexp()
	------------------------------------------------------------------------
	function luaY:constructor(ls, t)
		-- constructor -> '{' [ field { fieldsep field } [ fieldsep ] ] '}'
		-- field -> recfield | listfield
		-- fieldsep -> ',' | ';'
		local fs = ls.fs
		local line = ls.linenumber
		local pc = luaK:codeABC(fs, "OP_NEWTABLE", 0, 0, 0)
		local cc = {}  -- ConsControl
		cc.v = {}
		cc.na, cc.nh, cc.tostore = 0, 0, 0
		cc.t = t
		self:init_exp(t, "VRELOCABLE", pc)
		self:init_exp(cc.v, "VVOID", 0)  -- no value (yet)
		luaK:exp2nextreg(ls.fs, t)  -- fix it at stack top (for gc)
		self:checknext(ls, "{")
		repeat
			assert(cc.v.k == "VVOID" or cc.tostore > 0)
			if ls.t.token == "}" then break end
			self:closelistfield(fs, cc)
			local c = ls.t.token

			if c == "TK_NAME" then  -- may be listfields or recfields
				luaX:lookahead(ls)
				if ls.lookahead.token ~= "=" then  -- expression?
					self:listfield(ls, cc)
				else
					self:recfield(ls, cc)
				end
			elseif c == "[" then  -- constructor_item -> recfield
				self:recfield(ls, cc)
			else  -- constructor_part -> listfield
				self:listfield(ls, cc)
			end
		until not self:testnext(ls, ",") and not self:testnext(ls, ";")
		self:check_match(ls, "}", "{", line)
		self:lastlistfield(fs, cc)
		luaP:SETARG_B(fs.f.code[pc], self:int2fb(cc.na)) -- set initial array size
		luaP:SETARG_C(fs.f.code[pc], self:int2fb(cc.nh)) -- set initial table size
	end

	-- }======================================================================

	------------------------------------------------------------------------
	-- parse the arguments (parameters) of a function declaration
	-- * used in body()
	------------------------------------------------------------------------
	function luaY:parlist(ls)
		-- parlist -> [ param { ',' param } ]
		local fs = ls.fs
		local f = fs.f
		local nparams = 0
		f.is_vararg = 0
		if ls.t.token ~= ")" then  -- is 'parlist' not empty?
			repeat
				local c = ls.t.token
				if c == "TK_NAME" then  -- param -> NAME
					self:new_localvar(ls, self:str_checkname(ls), nparams)
					nparams = nparams + 1
				elseif c == "TK_DOTS" then  -- param -> `...'
					luaX:next(ls)
					-- [[
					-- #if defined(LUA_COMPAT_VARARG)
					-- use `arg' as default name
					self:new_localvarliteral(ls, "arg", nparams)
					nparams = nparams + 1
					f.is_vararg = self.VARARG_HASARG + self.VARARG_NEEDSARG
					-- #endif
					--]]
					f.is_vararg = f.is_vararg + self.VARARG_ISVARARG
				else
					luaX:syntaxerror(ls, "<name> or "..self:LUA_QL("...").." expected")
				end
			until f.is_vararg ~= 0 or not self:testnext(ls, ",")
		end--if
		self:adjustlocalvars(ls, nparams)
		-- NOTE: the following works only when HASARG_MASK is 2!
		f.numparams = fs.nactvar - (f.is_vararg % self.HASARG_MASK)
		luaK:reserveregs(fs, fs.nactvar)  -- reserve register for parameters
	end

	------------------------------------------------------------------------
	-- parse function declaration body
	-- * used in simpleexp(), localfunc(), funcstat()
	------------------------------------------------------------------------
	function luaY:body(ls, e, needself, line)
		-- body ->  '(' parlist ')' chunk END
		local new_fs = {}  -- FuncState
		new_fs.upvalues = {}
		new_fs.actvar = {}
		self:open_func(ls, new_fs)
		new_fs.f.lineDefined = line
		self:checknext(ls, "(")
		if needself then
			self:new_localvarliteral(ls, "self", 0)
			self:adjustlocalvars(ls, 1)
		end
		self:parlist(ls)
		self:checknext(ls, ")")
		self:chunk(ls)
		new_fs.f.lastlinedefined = ls.linenumber
		self:check_match(ls, "TK_END", "TK_FUNCTION", line)
		self:close_func(ls)
		self:pushclosure(ls, new_fs, e)
	end

	------------------------------------------------------------------------
	-- parse a list of comma-separated expressions
	-- * used is multiple locations
	------------------------------------------------------------------------
	function luaY:explist1(ls, v)
		-- explist1 -> expr { ',' expr }
		local n = 1  -- at least one expression
		self:expr(ls, v)
		while self:testnext(ls, ",") do
			luaK:exp2nextreg(ls.fs, v)
			self:expr(ls, v)
			n = n + 1
		end
		return n
	end

	------------------------------------------------------------------------
	-- parse the parameters of a function call
	-- * contrast with parlist(), used in function declarations
	-- * used in primaryexp()
	------------------------------------------------------------------------
	function luaY:funcargs(ls, f)
		local fs = ls.fs
		local args = {}  -- expdesc
		local nparams
		local line = ls.linenumber
		local c = ls.t.token
		if c == "(" then  -- funcargs -> '(' [ explist1 ] ')'
			if line ~= ls.lastline then
				luaX:syntaxerror(ls, "ambiguous syntax (function call x new statement)")
			end
			luaX:next(ls)
			if ls.t.token == ")" then  -- arg list is empty?
				args.k = "VVOID"
			else
				self:explist1(ls, args)
				luaK:setmultret(fs, args)
			end
			self:check_match(ls, ")", "(", line)
		elseif c == "{" then  -- funcargs -> constructor
			self:constructor(ls, args)
		elseif c == "TK_STRING" then  -- funcargs -> STRING
			self:codestring(ls, args, ls.t.seminfo)
			luaX:next(ls)  -- must use 'seminfo' before 'next'
		else
			luaX:syntaxerror(ls, "function arguments expected")
			return
		end
		assert(f.k == "VNONRELOC")
		local base = f.info  -- base register for call
		if self:hasmultret(args.k) then
			nparams = self.LUA_MULTRET  -- open call
		else
			if args.k ~= "VVOID" then
				luaK:exp2nextreg(fs, args)  -- close last argument
			end
			nparams = fs.freereg - (base + 1)
		end
		self:init_exp(f, "VCALL", luaK:codeABC(fs, "OP_CALL", base, nparams + 1, 2))
		luaK:fixline(fs, line)
		fs.freereg = base + 1  -- call remove function and arguments and leaves
		-- (unless changed) one result
	end

--[[--------------------------------------------------------------------
-- Expression parsing
----------------------------------------------------------------------]]

	------------------------------------------------------------------------
	-- parses an expression in parentheses or a single variable
	-- * used in primaryexp()
	------------------------------------------------------------------------
	function luaY:prefixexp(ls, v)
		-- prefixexp -> NAME | '(' expr ')'
		local c = ls.t.token
		if c == "(" then
			local line = ls.linenumber
			luaX:next(ls)
			self:expr(ls, v)
			self:check_match(ls, ")", "(", line)
			luaK:dischargevars(ls.fs, v)
		elseif c == "TK_NAME" then
			self:singlevar(ls, v)
		else
			luaX:syntaxerror(ls, "unexpected symbol")
		end--if c
		return
	end

	------------------------------------------------------------------------
	-- parses a prefixexp (an expression in parentheses or a single variable)
	-- or a function call specification
	-- * used in simpleexp(), assignment(), exprstat()
	------------------------------------------------------------------------
	function luaY:primaryexp(ls, v)
		-- primaryexp ->
		--    prefixexp { '.' NAME | '[' exp ']' | ':' NAME funcargs | funcargs }
		local fs = ls.fs
		self:prefixexp(ls, v)
		while true do
			local c = ls.t.token
			if c == "." then  -- field
				self:field(ls, v)
			elseif c == "[" then  -- '[' exp1 ']'
				local key = {}  -- expdesc
				luaK:exp2anyreg(fs, v)
				self:yindex(ls, key)
				luaK:indexed(fs, v, key)
			elseif c == ":" then  -- ':' NAME funcargs
				local key = {}  -- expdesc
				luaX:next(ls)
				self:checkname(ls, key)
				luaK:_self(fs, v, key)
				self:funcargs(ls, v)
			elseif c == "(" or c == "TK_STRING" or c == "{" then  -- funcargs
				luaK:exp2nextreg(fs, v)
				self:funcargs(ls, v)
			else
				return
			end--if c
		end--while
	end

	------------------------------------------------------------------------
	-- parses general expression types, constants handled here
	-- * used in subexpr()
	------------------------------------------------------------------------
	function luaY:simpleexp(ls, v)
		-- simpleexp -> NUMBER | STRING | NIL | TRUE | FALSE | ... |
		--              constructor | FUNCTION body | primaryexp
		local c = ls.t.token
		if c == "TK_NUMBER" then
			self:init_exp(v, "VKNUM", 0)
			v.nval = ls.t.seminfo
		elseif c == "TK_STRING" then
			self:codestring(ls, v, ls.t.seminfo)
		elseif c == "TK_NIL" then
			self:init_exp(v, "VNIL", 0)
		elseif c == "TK_TRUE" then
			self:init_exp(v, "VTRUE", 0)
		elseif c == "TK_FALSE" then
			self:init_exp(v, "VFALSE", 0)
		elseif c == "TK_DOTS" then  -- vararg
			local fs = ls.fs
			self:check_condition(ls, fs.f.is_vararg ~= 0,
				"cannot use "..self:LUA_QL("...").." outside a vararg function");
			-- NOTE: the following substitutes for a bitop, but is value-specific
			local is_vararg = fs.f.is_vararg
			if is_vararg >= self.VARARG_NEEDSARG then
				fs.f.is_vararg = is_vararg - self.VARARG_NEEDSARG  -- don't need 'arg'
			end
			self:init_exp(v, "VVARARG", luaK:codeABC(fs, "OP_VARARG", 0, 1, 0))
		elseif c == "{" then  -- constructor
			self:constructor(ls, v)
			return
		elseif c == "TK_FUNCTION" then
			luaX:next(ls)
			self:body(ls, v, false, ls.linenumber)
			return
		else
			self:primaryexp(ls, v)
			return
		end--if c
		luaX:next(ls)
	end

	------------------------------------------------------------------------
	-- Translates unary operators tokens if found, otherwise returns
	-- OPR_NOUNOPR. getunopr() and getbinopr() are used in subexpr().
	-- * used in subexpr()
	------------------------------------------------------------------------
	function luaY:getunopr(op)
		if op == "TK_NOT" then
			return "OPR_NOT"
		elseif op == "-" then
			return "OPR_MINUS"
		elseif op == "#" then
			return "OPR_LEN"
		else
			return "OPR_NOUNOPR"
		end
	end

	------------------------------------------------------------------------
	-- Translates binary operator tokens if found, otherwise returns
	-- OPR_NOBINOPR. Code generation uses OPR_* style tokens.
	-- * used in subexpr()
	------------------------------------------------------------------------
	luaY.getbinopr_table = {
		["+"] = "OPR_ADD",
		["-"] = "OPR_SUB",
		["*"] = "OPR_MUL",
		["/"] = "OPR_DIV",
		["%"] = "OPR_MOD",
		["^"] = "OPR_POW",
		["TK_CONCAT"] = "OPR_CONCAT",
		["TK_NE"] = "OPR_NE",
		["TK_EQ"] = "OPR_EQ",
		["<"] = "OPR_LT",
		["TK_LE"] = "OPR_LE",
		[">"] = "OPR_GT",
		["TK_GE"] = "OPR_GE",
		["TK_AND"] = "OPR_AND",
		["TK_OR"] = "OPR_OR",
	}
	function luaY:getbinopr(op)
		local opr = self.getbinopr_table[op]
		if opr then return opr else return "OPR_NOBINOPR" end
	end

	------------------------------------------------------------------------
	-- the following priority table consists of pairs of left/right values
	-- for binary operators (was a static const struct); grep for ORDER OPR
	-- * the following struct is replaced:
	--   static const struct {
	--     lu_byte left;  /* left priority for each binary operator */
	--     lu_byte right; /* right priority */
	--   } priority[] = {  /* ORDER OPR */
	------------------------------------------------------------------------
	luaY.priority = {
		{6, 6}, {6, 6}, {7, 7}, {7, 7}, {7, 7}, -- `+' `-' `/' `%'
		{10, 9}, {5, 4},                 -- power and concat (right associative)
		{3, 3}, {3, 3},                  -- equality
		{3, 3}, {3, 3}, {3, 3}, {3, 3},  -- order
		{2, 2}, {1, 1}                   -- logical (and/or)
	}

	luaY.UNARY_PRIORITY = 8  -- priority for unary operators

	------------------------------------------------------------------------
	-- Parse subexpressions. Includes handling of unary operators and binary
	-- operators. A subexpr is given the rhs priority level of the operator
	-- immediately left of it, if any (limit is -1 if none,) and if a binop
	-- is found, limit is compared with the lhs priority level of the binop
	-- in order to determine which executes first.
	------------------------------------------------------------------------

	------------------------------------------------------------------------
	-- subexpr -> (simpleexp | unop subexpr) { binop subexpr }
	-- where 'binop' is any binary operator with a priority higher than 'limit'
	-- * for priority lookups with self.priority[], 1=left and 2=right
	-- * recursively called
	-- * used in expr()
	------------------------------------------------------------------------
	function luaY:subexpr(ls, v, limit)
		self:enterlevel(ls)
		local uop = self:getunopr(ls.t.token)
		if uop ~= "OPR_NOUNOPR" then
			luaX:next(ls)
			self:subexpr(ls, v, self.UNARY_PRIORITY)
			luaK:prefix(ls.fs, uop, v)
		else
			self:simpleexp(ls, v)
		end
		-- expand while operators have priorities higher than 'limit'
		local op = self:getbinopr(ls.t.token)
		while op ~= "OPR_NOBINOPR" and self.priority[luaK.BinOpr[op] + 1][1] > limit do
			local v2 = {}  -- expdesc
			luaX:next(ls)
			luaK:infix(ls.fs, op, v)
			-- read sub-expression with higher priority
			local nextop = self:subexpr(ls, v2, self.priority[luaK.BinOpr[op] + 1][2])
			luaK:posfix(ls.fs, op, v, v2)
			op = nextop
		end
		self:leavelevel(ls)
		return op  -- return first untreated operator
	end

	------------------------------------------------------------------------
	-- Expression parsing starts here. Function subexpr is entered with the
	-- left operator (which is non-existent) priority of -1, which is lower
	-- than all actual operators. Expr information is returned in parm v.
	-- * used in multiple locations
	------------------------------------------------------------------------
	function luaY:expr(ls, v)
		self:subexpr(ls, v, 0)
	end

	-- }====================================================================

--[[--------------------------------------------------------------------
-- Rules for Statements
----------------------------------------------------------------------]]

	------------------------------------------------------------------------
	-- checks next token, used as a look-ahead
	-- * returns boolean instead of 0|1
	-- * used in retstat(), chunk()
	------------------------------------------------------------------------
	function luaY:block_follow(token)
		if token == "TK_ELSE" or token == "TK_ELSEIF" or token == "TK_END"
			or token == "TK_UNTIL" or token == "TK_EOS" then
			return true
		else
			return false
		end
	end

	------------------------------------------------------------------------
	-- parse a code block or unit
	-- * used in multiple functions
	------------------------------------------------------------------------
	function luaY:block(ls)
		-- block -> chunk
		local fs = ls.fs
		local bl = {}  -- BlockCnt
		self:enterblock(fs, bl, false)
		self:chunk(ls)
		assert(bl.breaklist == luaK.NO_JUMP)
		self:leaveblock(fs)
	end

	------------------------------------------------------------------------
	-- structure to chain all variables in the left-hand side of an
	-- assignment
	-- struct LHS_assign:
	--   prev  -- (table: struct LHS_assign)
	--   v  -- variable (global, local, upvalue, or indexed) (table: expdesc)
	------------------------------------------------------------------------

	------------------------------------------------------------------------
	-- check whether, in an assignment to a local variable, the local variable
	-- is needed in a previous assignment (to a table). If so, save original
	-- local value in a safe place and use this safe copy in the previous
	-- assignment.
	-- * used in assignment()
	------------------------------------------------------------------------
	function luaY:check_conflict(ls, lh, v)
		local fs = ls.fs
		local extra = fs.freereg  -- eventual position to save local variable
		local conflict = false
		while lh do
			if lh.v.k == "VINDEXED" then
				if lh.v.info == v.info then  -- conflict?
					conflict = true
					lh.v.info = extra  -- previous assignment will use safe copy
				end
				if lh.v.aux == v.info then  -- conflict?
					conflict = true
					lh.v.aux = extra  -- previous assignment will use safe copy
				end
			end
			lh = lh.prev
		end
		if conflict then
			luaK:codeABC(fs, "OP_MOVE", fs.freereg, v.info, 0)  -- make copy
			luaK:reserveregs(fs, 1)
		end
	end

	------------------------------------------------------------------------
	-- parse a variable assignment sequence
	-- * recursively called
	-- * used in exprstat()
	------------------------------------------------------------------------
	function luaY:assignment(ls, lh, nvars)
		local e = {}  -- expdesc
		-- test was: VLOCAL <= lh->v.k && lh->v.k <= VINDEXED
		local c = lh.v.k
		self:check_condition(ls, c == "VLOCAL" or c == "VUPVAL" or c == "VGLOBAL"
			or c == "VINDEXED", "syntax error")
		if self:testnext(ls, ",") then  -- assignment -> ',' primaryexp assignment
			local nv = {}  -- LHS_assign
			nv.v = {}
			nv.prev = lh
			self:primaryexp(ls, nv.v)
			if nv.v.k == "VLOCAL" then
				self:check_conflict(ls, lh, nv.v)
			end
			self:checklimit(ls.fs, nvars, self.LUAI_MAXCCALLS - ls.L.nCcalls,
				"variables in assignment")
			self:assignment(ls, nv, nvars + 1)
		else  -- assignment -> '=' explist1
			self:checknext(ls, "=")
			local nexps = self:explist1(ls, e)
			if nexps ~= nvars then
				self:adjust_assign(ls, nvars, nexps, e)
				if nexps > nvars then
					ls.fs.freereg = ls.fs.freereg - (nexps - nvars)  -- remove extra values
				end
			else
				luaK:setoneret(ls.fs, e)  -- close last expression
				luaK:storevar(ls.fs, lh.v, e)
				return  -- avoid default
			end
		end
		self:init_exp(e, "VNONRELOC", ls.fs.freereg - 1)  -- default assignment
		luaK:storevar(ls.fs, lh.v, e)
	end

	------------------------------------------------------------------------
	-- parse condition in a repeat statement or an if control structure
	-- * used in repeatstat(), test_then_block()
	------------------------------------------------------------------------
	function luaY:cond(ls)
		-- cond -> exp
		local v = {}  -- expdesc
		self:expr(ls, v)  -- read condition
		if v.k == "VNIL" then v.k = "VFALSE" end  -- 'falses' are all equal here
		luaK:goiftrue(ls.fs, v)
		return v.f
	end

	------------------------------------------------------------------------
	-- parse a break statement
	-- * used in statements()
	------------------------------------------------------------------------
	function luaY:breakstat(ls)
		-- stat -> BREAK
		local fs = ls.fs
		local bl = fs.bl
		local upval = false
		while bl and not bl.isbreakable do
			if bl.upval then upval = true end
			bl = bl.previous
		end
		if not bl then
			luaX:syntaxerror(ls, "no loop to break")
		end
		if upval then
			luaK:codeABC(fs, "OP_CLOSE", bl.nactvar, 0, 0)
		end
		bl.breaklist = luaK:concat(fs, bl.breaklist, luaK:jump(fs))
	end

	------------------------------------------------------------------------
	-- parse a while-do control structure, body processed by block()
	-- * with dynamic array sizes, MAXEXPWHILE + EXTRAEXP limits imposed by
	--   the function's implementation can be removed
	-- * used in statements()
	------------------------------------------------------------------------
	function luaY:whilestat(ls, line)
		-- whilestat -> WHILE cond DO block END
		local fs = ls.fs
		local bl = {}  -- BlockCnt
		luaX:next(ls)  -- skip WHILE
		local whileinit = luaK:getlabel(fs)
		local condexit = self:cond(ls)
		self:enterblock(fs, bl, true)
		self:checknext(ls, "TK_DO")
		self:block(ls)
		luaK:patchlist(fs, luaK:jump(fs), whileinit)
		self:check_match(ls, "TK_END", "TK_WHILE", line)
		self:leaveblock(fs)
		luaK:patchtohere(fs, condexit)  -- false conditions finish the loop
	end

	------------------------------------------------------------------------
	-- parse a repeat-until control structure, body parsed by chunk()
	-- * used in statements()
	------------------------------------------------------------------------
	function luaY:repeatstat(ls, line)
		-- repeatstat -> REPEAT block UNTIL cond
		local fs = ls.fs
		local repeat_init = luaK:getlabel(fs)
		local bl1, bl2 = {}, {}  -- BlockCnt
		self:enterblock(fs, bl1, true)  -- loop block
		self:enterblock(fs, bl2, false)  -- scope block
		luaX:next(ls)  -- skip REPEAT
		self:chunk(ls)
		self:check_match(ls, "TK_UNTIL", "TK_REPEAT", line)
		local condexit = self:cond(ls)  -- read condition (inside scope block)
		if not bl2.upval then  -- no upvalues?
			self:leaveblock(fs)  -- finish scope
			luaK:patchlist(ls.fs, condexit, repeat_init)  -- close the loop
		else  -- complete semantics when there are upvalues
			self:breakstat(ls)  -- if condition then break
			luaK:patchtohere(ls.fs, condexit)  -- else...
			self:leaveblock(fs)  -- finish scope...
			luaK:patchlist(ls.fs, luaK:jump(fs), repeat_init)  -- and repeat
		end
		self:leaveblock(fs)  -- finish loop
	end

	------------------------------------------------------------------------
	-- parse the single expressions needed in numerical for loops
	-- * used in fornum()
	------------------------------------------------------------------------
	function luaY:exp1(ls)
		local e = {}  -- expdesc
		self:expr(ls, e)
		local k = e.k
		luaK:exp2nextreg(ls.fs, e)
		return k
	end

	------------------------------------------------------------------------
	-- parse a for loop body for both versions of the for loop
	-- * used in fornum(), forlist()
	------------------------------------------------------------------------
	function luaY:forbody(ls, base, line, nvars, isnum)
		-- forbody -> DO block
		local bl = {}  -- BlockCnt
		local fs = ls.fs
		self:adjustlocalvars(ls, 3)  -- control variables
		self:checknext(ls, "TK_DO")
		local prep = isnum and luaK:codeAsBx(fs, "OP_FORPREP", base, luaK.NO_JUMP)
			or luaK:jump(fs)
		self:enterblock(fs, bl, false)  -- scope for declared variables
		self:adjustlocalvars(ls, nvars)
		luaK:reserveregs(fs, nvars)
		self:block(ls)
		self:leaveblock(fs)  -- end of scope for declared variables
		luaK:patchtohere(fs, prep)
		local endfor = isnum and luaK:codeAsBx(fs, "OP_FORLOOP", base, luaK.NO_JUMP)
			or luaK:codeABC(fs, "OP_TFORLOOP", base, 0, nvars)
		luaK:fixline(fs, line)  -- pretend that `OP_FOR' starts the loop
		luaK:patchlist(fs, isnum and endfor or luaK:jump(fs), prep + 1)
	end

	------------------------------------------------------------------------
	-- parse a numerical for loop, calls forbody()
	-- * used in forstat()
	------------------------------------------------------------------------
	function luaY:fornum(ls, varname, line)
		-- fornum -> NAME = exp1,exp1[,exp1] forbody
		local fs = ls.fs
		local base = fs.freereg
		self:new_localvarliteral(ls, "(for index)", 0)
		self:new_localvarliteral(ls, "(for limit)", 1)
		self:new_localvarliteral(ls, "(for step)", 2)
		self:new_localvar(ls, varname, 3)
		self:checknext(ls, '=')
		self:exp1(ls)  -- initial value
		self:checknext(ls, ",")
		self:exp1(ls)  -- limit
		if self:testnext(ls, ",") then
			self:exp1(ls)  -- optional step
		else  -- default step = 1
			luaK:codeABx(fs, "OP_LOADK", fs.freereg, luaK:numberK(fs, 1))
			luaK:reserveregs(fs, 1)
		end
		self:forbody(ls, base, line, 1, true)
	end

	------------------------------------------------------------------------
	-- parse a generic for loop, calls forbody()
	-- * used in forstat()
	------------------------------------------------------------------------
	function luaY:forlist(ls, indexname)
		-- forlist -> NAME {,NAME} IN explist1 forbody
		local fs = ls.fs
		local e = {}  -- expdesc
		local nvars = 0
		local base = fs.freereg
		-- create control variables
		self:new_localvarliteral(ls, "(for generator)", nvars)
		nvars = nvars + 1
		self:new_localvarliteral(ls, "(for state)", nvars)
		nvars = nvars + 1
		self:new_localvarliteral(ls, "(for control)", nvars)
		nvars = nvars + 1
		-- create declared variables
		self:new_localvar(ls, indexname, nvars)
		nvars = nvars + 1
		while self:testnext(ls, ",") do
			self:new_localvar(ls, self:str_checkname(ls), nvars)
			nvars = nvars + 1
		end
		self:checknext(ls, "TK_IN")
		local line = ls.linenumber
		self:adjust_assign(ls, 3, self:explist1(ls, e), e)
		luaK:checkstack(fs, 3)  -- extra space to call generator
		self:forbody(ls, base, line, nvars - 3, false)
	end

	------------------------------------------------------------------------
	-- initial parsing for a for loop, calls fornum() or forlist()
	-- * used in statements()
	------------------------------------------------------------------------
	function luaY:forstat(ls, line)
		-- forstat -> FOR (fornum | forlist) END
		local fs = ls.fs
		local bl = {}  -- BlockCnt
		self:enterblock(fs, bl, true)  -- scope for loop and control variables
		luaX:next(ls)  -- skip `for'
		local varname = self:str_checkname(ls)  -- first variable name
		local c = ls.t.token
		if c == "=" then
			self:fornum(ls, varname, line)
		elseif c == "," or c == "TK_IN" then
			self:forlist(ls, varname)
		else
			luaX:syntaxerror(ls, self:LUA_QL("=").." or "..self:LUA_QL("in").." expected")
		end
		self:check_match(ls, "TK_END", "TK_FOR", line)
		self:leaveblock(fs)  -- loop scope (`break' jumps to this point)
	end

	------------------------------------------------------------------------
	-- parse part of an if control structure, including the condition
	-- * used in ifstat()
	------------------------------------------------------------------------
	function luaY:test_then_block(ls)
		-- test_then_block -> [IF | ELSEIF] cond THEN block
		luaX:next(ls)  -- skip IF or ELSEIF
		local condexit = self:cond(ls)
		self:checknext(ls, "TK_THEN")
		self:block(ls)  -- `then' part
		return condexit
	end

	------------------------------------------------------------------------
	-- parse an if control structure
	-- * used in statements()
	------------------------------------------------------------------------
	function luaY:ifstat(ls, line)
		-- ifstat -> IF cond THEN block {ELSEIF cond THEN block} [ELSE block] END
		local fs = ls.fs
		local escapelist = luaK.NO_JUMP
		local flist = self:test_then_block(ls)  -- IF cond THEN block
		while ls.t.token == "TK_ELSEIF" do
			escapelist = luaK:concat(fs, escapelist, luaK:jump(fs))
			luaK:patchtohere(fs, flist)
			flist = self:test_then_block(ls)  -- ELSEIF cond THEN block
		end
		if ls.t.token == "TK_ELSE" then
			escapelist = luaK:concat(fs, escapelist, luaK:jump(fs))
			luaK:patchtohere(fs, flist)
			luaX:next(ls)  -- skip ELSE (after patch, for correct line info)
			self:block(ls)  -- 'else' part
		else
			escapelist = luaK:concat(fs, escapelist, flist)
		end
		luaK:patchtohere(fs, escapelist)
		self:check_match(ls, "TK_END", "TK_IF", line)
	end

	------------------------------------------------------------------------
	-- parse a local function statement
	-- * used in statements()
	------------------------------------------------------------------------
	function luaY:localfunc(ls)
		local v, b = {}, {}  -- expdesc
		local fs = ls.fs
		self:new_localvar(ls, self:str_checkname(ls), 0)
		self:init_exp(v, "VLOCAL", fs.freereg)
		luaK:reserveregs(fs, 1)
		self:adjustlocalvars(ls, 1)
		self:body(ls, b, false, ls.linenumber)
		luaK:storevar(fs, v, b)
		-- debug information will only see the variable after this point!
		self:getlocvar(fs, fs.nactvar - 1).startpc = fs.pc
	end

	------------------------------------------------------------------------
	-- parse a local variable declaration statement
	-- * used in statements()
	------------------------------------------------------------------------
	function luaY:localstat(ls)
		-- stat -> LOCAL NAME {',' NAME} ['=' explist1]
		local nvars = 0
		local nexps
		local e = {}  -- expdesc
		repeat
			self:new_localvar(ls, self:str_checkname(ls), nvars)
			nvars = nvars + 1
		until not self:testnext(ls, ",")
		if self:testnext(ls, "=") then
			nexps = self:explist1(ls, e)
		else
			e.k = "VVOID"
			nexps = 0
		end
		self:adjust_assign(ls, nvars, nexps, e)
		self:adjustlocalvars(ls, nvars)
	end

	------------------------------------------------------------------------
	-- parse a function name specification
	-- * used in funcstat()
	------------------------------------------------------------------------
	function luaY:funcname(ls, v)
		-- funcname -> NAME {field} [':' NAME]
		local needself = false
		self:singlevar(ls, v)
		while ls.t.token == "." do
			self:field(ls, v)
		end
		if ls.t.token == ":" then
			needself = true
			self:field(ls, v)
		end
		return needself
	end

	------------------------------------------------------------------------
	-- parse a function statement
	-- * used in statements()
	------------------------------------------------------------------------
	function luaY:funcstat(ls, line)
		-- funcstat -> FUNCTION funcname body
		local v, b = {}, {}  -- expdesc
		luaX:next(ls)  -- skip FUNCTION
		local needself = self:funcname(ls, v)
		self:body(ls, b, needself, line)
		luaK:storevar(ls.fs, v, b)
		luaK:fixline(ls.fs, line)  -- definition 'happens' in the first line
	end

	------------------------------------------------------------------------
	-- parse a function call with no returns or an assignment statement
	-- * used in statements()
	------------------------------------------------------------------------
	function luaY:exprstat(ls)
		-- stat -> func | assignment
		local fs = ls.fs
		local v = {}  -- LHS_assign
		v.v = {}
		self:primaryexp(ls, v.v)
		if v.v.k == "VCALL" then  -- stat -> func
			luaP:SETARG_C(luaK:getcode(fs, v.v), 1)  -- call statement uses no results
		else  -- stat -> assignment
			v.prev = nil
			self:assignment(ls, v, 1)
		end
	end

	------------------------------------------------------------------------
	-- parse a return statement
	-- * used in statements()
	------------------------------------------------------------------------
	function luaY:retstat(ls)
		-- stat -> RETURN explist
		local fs = ls.fs
		local e = {}  -- expdesc
		local first, nret  -- registers with returned values
		luaX:next(ls)  -- skip RETURN
		if self:block_follow(ls.t.token) or ls.t.token == ";" then
			first, nret = 0, 0  -- return no values
		else
			nret = self:explist1(ls, e)  -- optional return values
			if self:hasmultret(e.k) then
				luaK:setmultret(fs, e)
				if e.k == "VCALL" and nret == 1 then  -- tail call?
					luaP:SET_OPCODE(luaK:getcode(fs, e), "OP_TAILCALL")
					assert(luaP:GETARG_A(luaK:getcode(fs, e)) == fs.nactvar)
				end
				first = fs.nactvar
				nret = self.LUA_MULTRET  -- return all values
			else
				if nret == 1 then  -- only one single value?
					first = luaK:exp2anyreg(fs, e)
				else
					luaK:exp2nextreg(fs, e)  -- values must go to the 'stack'
					first = fs.nactvar  -- return all 'active' values
					assert(nret == fs.freereg - first)
				end
			end--if
		end--if
		luaK:ret(fs, first, nret)
	end

	------------------------------------------------------------------------
	-- initial parsing for statements, calls a lot of functions
	-- * returns boolean instead of 0|1
	-- * used in chunk()
	------------------------------------------------------------------------
	function luaY:statement(ls)
		local line = ls.linenumber  -- may be needed for error messages
		local c = ls.t.token
		if c == "TK_IF" then  -- stat -> ifstat
			self:ifstat(ls, line)
			return false
		elseif c == "TK_WHILE" then  -- stat -> whilestat
			self:whilestat(ls, line)
			return false
		elseif c == "TK_DO" then  -- stat -> DO block END
			luaX:next(ls)  -- skip DO
			self:block(ls)
			self:check_match(ls, "TK_END", "TK_DO", line)
			return false
		elseif c == "TK_FOR" then  -- stat -> forstat
			self:forstat(ls, line)
			return false
		elseif c == "TK_REPEAT" then  -- stat -> repeatstat
			self:repeatstat(ls, line)
			return false
		elseif c == "TK_FUNCTION" then  -- stat -> funcstat
			self:funcstat(ls, line)
			return false
		elseif c == "TK_LOCAL" then  -- stat -> localstat
			luaX:next(ls)  -- skip LOCAL
			if self:testnext(ls, "TK_FUNCTION") then  -- local function?
				self:localfunc(ls)
			else
				self:localstat(ls)
			end
			return false
		elseif c == "TK_RETURN" then  -- stat -> retstat
			self:retstat(ls)
			return true  -- must be last statement
		elseif c == "TK_BREAK" then  -- stat -> breakstat
			luaX:next(ls)  -- skip BREAK
			self:breakstat(ls)
			return true  -- must be last statement
		else
			self:exprstat(ls)
			return false  -- to avoid warnings
		end--if c
	end

	------------------------------------------------------------------------
	-- parse a chunk, which consists of a bunch of statements
	-- * used in parser(), body(), block(), repeatstat()
	------------------------------------------------------------------------
	function luaY:chunk(ls)
		-- chunk -> { stat [';'] }
		local islast = false
		self:enterlevel(ls)
		while not islast and not self:block_follow(ls.t.token) do
			islast = self:statement(ls)
			self:testnext(ls, ";")
			assert(ls.fs.f.maxstacksize >= ls.fs.freereg and
				ls.fs.freereg >= ls.fs.nactvar)
			ls.fs.freereg = ls.fs.nactvar  -- free registers
		end
		self:leavelevel(ls)
	end

	-- }======================================================================

--[[--------------------------------------------------------------------

  lzio.lua
  Lua buffered streams in Lua
  This file is part of Yueliang.

  Copyright (c) 2005-2006 Kein-Hong Man <khman@users.sf.net>
  The COPYRIGHT file describes the conditions
  under which this software may be distributed.

  See the ChangeLog for more information.

----------------------------------------------------------------------]]

--[[--------------------------------------------------------------------
-- Notes:
-- * EOZ is implemented as a string, "EOZ"
-- * Format of z structure (ZIO)
--     z.n       -- bytes still unread
--     z.p       -- last read position position in buffer
--     z.reader  -- chunk reader function
--     z.data    -- additional data
-- * Current position, p, is now last read index instead of a pointer
--
-- Not implemented:
-- * luaZ_lookahead: used only in lapi.c:lua_load to detect binary chunk
-- * luaZ_read: used only in lundump.c:ezread to read +1 bytes
-- * luaZ_openspace: dropped; let Lua handle buffers as strings (used in
--   lundump.c:Load String & lvm.c:luaV_concat)
-- * luaZ buffer macros: dropped; buffers are handled as strings
-- * lauxlib.c:getF reader implementation has an extraline flag to
--   skip over a shbang (#!) line, this is not implemented here
--
-- Added:
-- (both of the following are vaguely adapted from lauxlib.c)
-- * luaZ:make_getS: create Reader from a string
-- * luaZ:make_getF: create Reader that reads from a file
--
-- Changed in 5.1.x:
-- * Chunkreader renamed to Reader (ditto with Chunkwriter)
-- * Zio struct: no more name string, added Lua state for reader
--   (however, Yueliang readers do not require a Lua state)
----------------------------------------------------------------------]]

--[[--------------------------------------------------------------------

  ldump.lua
  Save precompiled Lua chunks
  This file is part of Yueliang.

  Copyright (c) 2006 Kein-Hong Man <khman@users.sf.net>
  The COPYRIGHT file describes the conditions
  under which this software may be distributed.

  See the ChangeLog for more information.

----------------------------------------------------------------------]]

--[[--------------------------------------------------------------------
-- Notes:
-- * WARNING! byte order (little endian) and data type sizes for header
--   signature values hard-coded; see luaU:header
-- * chunk writer generators are included, see below
-- * one significant difference is that instructions are still in table
--   form (with OP/A/B/C/Bx fields) and luaP:Instruction() is needed to
--   convert them into 4-char strings
--
-- Not implemented:
-- * DumpVar, DumpMem has been removed
-- * DumpVector folded into folded into DumpDebug, DumpCode
--
-- Added:
-- * for convenience, the following two functions have been added:
--   luaU:make_setS: create a chunk writer that writes to a string
--   luaU:make_setF: create a chunk writer that writes to a file
--   (lua.h contains a typedef for lua_Writer/lua_Chunkwriter, and
--    a Lua-based implementation exists, writer() in lstrlib.c)
-- * luaU:ttype(o) (from lobject.h)
-- * for converting number types to its binary equivalent:
--   luaU:from_double(x): encode double value for writing
--   luaU:from_int(x): encode integer value for writing
--     (error checking is limited for these conversion functions)
--     (double conversion does not support denormals or NaNs)
--
-- Changed in 5.1.x:
-- * the dumper was mostly rewritten in Lua 5.1.x, so notes on the
--   differences between 5.0.x and 5.1.x is limited
-- * LUAC_VERSION bumped to 0x51, LUAC_FORMAT added
-- * developer is expected to adjust LUAC_FORMAT in order to identify
--   non-standard binary chunk formats
-- * header signature code is smaller, has been simplified, and is
--   tested as a single unit; its logic is shared with the undumper
-- * no more endian conversion, invalid endianness mean rejection
-- * opcode field sizes are no longer exposed in the header
-- * code moved to front of a prototype, followed by constants
-- * debug information moved to the end of the binary chunk, and the
--   relevant functions folded into a single function
-- * luaU:dump returns a writer status code
-- * chunk writer now implements status code because dumper uses it
-- * luaU:endianness removed
----------------------------------------------------------------------]]

	--requires luaP
	local luaU = {}

	-- mark for precompiled code ('<esc>Lua') (from lua.h)
	luaU.LUA_SIGNATURE = "\27Lua"

	-- constants used by dumper (from lua.h)
	luaU.LUA_TNUMBER  = 3
	luaU.LUA_TSTRING  = 4
	luaU.LUA_TNIL     = 0
	luaU.LUA_TBOOLEAN = 1
	luaU.LUA_TNONE    = -1

	-- constants for header of binary files (from lundump.h)
	luaU.LUAC_VERSION    = 0x51     -- this is Lua 5.1
	luaU.LUAC_FORMAT     = 0        -- this is the official format
	luaU.LUAC_HEADERSIZE = 12       -- size of header of binary files

--[[--------------------------------------------------------------------
-- Additional functions to handle chunk writing
-- * to use make_setS and make_setF, see test_ldump.lua elsewhere
----------------------------------------------------------------------]]

	------------------------------------------------------------------------
	-- create a chunk writer that writes to a string
	-- * returns the writer function and a table containing the string
	-- * to get the final result, look in buff.data
	------------------------------------------------------------------------
	function luaU:make_setS()
		local buff = {}
		buff.data = ""
		local writer =
			function(s, buff)  -- chunk writer
				if not s then return 0 end
				buff.data = buff.data..s
				return 0
			end
		return writer, buff
	end

	------------------------------------------------------------------------
	-- create a chunk writer that writes to a file
	-- * returns the writer function and a table containing the file handle
	-- * if a nil is passed, then writer should close the open file
	------------------------------------------------------------------------

--[[
function luaU:make_setF(filename)
  local buff = {}
        buff.h = io.open(filename, "wb")
  if not buff.h then return nil end
  local writer =
    function(s, buff)  -- chunk writer
      if not buff.h then return 0 end
      if not s then
        if buff.h:close() then return 0 end
      else
        if buff.h:write(s) then return 0 end
      end
      return 1
    end
  return writer, buff
end--]]

	------------------------------------------------------------------------
	-- works like the lobject.h version except that TObject used in these
	-- scripts only has a 'value' field, no 'tt' field (native types used)
	------------------------------------------------------------------------
	function luaU:ttype(o)
		local tt = type(o.value)
		if tt == "number" then return self.LUA_TNUMBER
		elseif tt == "string" then return self.LUA_TSTRING
		elseif tt == "nil" then return self.LUA_TNIL
		elseif tt == "boolean" then return self.LUA_TBOOLEAN
		else
			return self.LUA_TNONE  -- the rest should not appear
		end
	end

	-----------------------------------------------------------------------
	-- converts a IEEE754 double number to an 8-byte little-endian string
	-- * luaU:from_double() and luaU:from_int() are adapted from ChunkBake
	-- * supports +/- Infinity, but not denormals or NaNs
	-----------------------------------------------------------------------
	function luaU:from_double(x)
		local function grab_byte(v)
			local c = v % 256
			return (v - c) / 256, string.char(c)
		end
		local sign = 0
		if x < 0 then sign = 1; x = -x end
		local mantissa, exponent = math.frexp(x)
		if x == 0 then -- zero
			mantissa, exponent = 0, 0
		elseif x == 1/0 then
			mantissa, exponent = 0, 2047
		else
			mantissa = (mantissa * 2 - 1) * math.ldexp(0.5, 53)
			exponent = exponent + 1022
		end
		local v, byte = "", nil -- convert to bytes
		x = math.floor(mantissa)
		for i = 1,6 do
			x, byte = grab_byte(x); v = v..byte -- 47:0
		end
		x, byte = grab_byte(exponent * 16 + x); v = v..byte -- 55:48
		x, byte = grab_byte(sign * 128 + x); v = v..byte -- 63:56
		return v
	end

	-----------------------------------------------------------------------
	-- converts a number to a little-endian 32-bit integer string
	-- * input value assumed to not overflow, can be signed/unsigned
	-----------------------------------------------------------------------
	function luaU:from_int(x)
		local v = ""
		x = math.floor(x)
		if x < 0 then x = 4294967296 + x end  -- ULONG_MAX+1
		for i = 1, 4 do
			local c = x % 256
			v = v..string.char(c); x = math.floor(x / 256)
		end
		return v
	end

--[[--------------------------------------------------------------------
-- Functions to make a binary chunk
-- * many functions have the size parameter removed, since output is
--   in the form of a string and some sizes are implicit or hard-coded
----------------------------------------------------------------------]]

--[[--------------------------------------------------------------------
-- struct DumpState:
--   L  -- lua_State (not used in this script)
--   writer  -- lua_Writer (chunk writer function)
--   data  -- void* (chunk writer context or data already written)
--   strip  -- if true, don't write any debug information
--   status  -- if non-zero, an error has occured
----------------------------------------------------------------------]]

	------------------------------------------------------------------------
	-- dumps a block of bytes
	-- * lua_unlock(D.L), lua_lock(D.L) unused
	------------------------------------------------------------------------
	function luaU:DumpBlock(b, D)
		if D.status == 0 then
			-- lua_unlock(D->L);
			D.status = D.write(b, D.data)
			-- lua_lock(D->L);
		end
	end

	------------------------------------------------------------------------
	-- dumps a char
	------------------------------------------------------------------------
	function luaU:DumpChar(y, D)
		self:DumpBlock(string.char(y), D)
	end

	------------------------------------------------------------------------
	-- dumps a 32-bit signed or unsigned integer (for int) (hard-coded)
	------------------------------------------------------------------------
	function luaU:DumpInt(x, D)
		self:DumpBlock(self:from_int(x), D)
	end

	------------------------------------------------------------------------
	-- dumps a lua_Number (hard-coded as a double)
	------------------------------------------------------------------------
	function luaU:DumpNumber(x, D)
		self:DumpBlock(self:from_double(x), D)
	end

	------------------------------------------------------------------------
	-- dumps a Lua string (size type is hard-coded)
	------------------------------------------------------------------------
	function luaU:DumpString(s, D)
		if s == nil then
			self:DumpInt(0, D)
		else
			s = s.."\0"  -- include trailing '\0'
			self:DumpInt(#s, D)
			self:DumpBlock(s, D)
		end
	end

	------------------------------------------------------------------------
	-- dumps instruction block from function prototype
	------------------------------------------------------------------------
	function luaU:DumpCode(f, D)
		local n = f.sizecode
		--was DumpVector
		self:DumpInt(n, D)
		for i = 0, n - 1 do
			self:DumpBlock(luaP:Instruction(f.code[i]), D)
		end
	end

	------------------------------------------------------------------------
	-- dump constant pool from function prototype
	-- * bvalue(o), nvalue(o) and rawtsvalue(o) macros removed
	------------------------------------------------------------------------
	function luaU:DumpConstants(f, D)
		local n = f.sizek
		self:DumpInt(n, D)
		for i = 0, n - 1 do
			local o = f.k[i]  -- TValue
			local tt = self:ttype(o)
			self:DumpChar(tt, D)
			if tt == self.LUA_TNIL then
			elseif tt == self.LUA_TBOOLEAN then
				self:DumpChar(o.value and 1 or 0, D)
			elseif tt == self.LUA_TNUMBER then
				self:DumpNumber(o.value, D)
			elseif tt == self.LUA_TSTRING then
				self:DumpString(o.value, D)
			else
				--lua_assert(0)  -- cannot happen
			end
		end
		n = f.sizep
		self:DumpInt(n, D)
		for i = 0, n - 1 do
			self:DumpFunction(f.p[i], f.source, D)
		end
	end

	------------------------------------------------------------------------
	-- dump debug information
	------------------------------------------------------------------------
	function luaU:DumpDebug(f, D)
		local n
		n = D.strip and 0 or f.sizelineinfo           -- dump line information
		--was DumpVector
		self:DumpInt(n, D)
		for i = 0, n - 1 do
			self:DumpInt(f.lineinfo[i], D)
		end
		n = D.strip and 0 or f.sizelocvars            -- dump local information
		self:DumpInt(n, D)
		for i = 0, n - 1 do
			self:DumpString(f.locvars[i].varname, D)
			self:DumpInt(f.locvars[i].startpc, D)
			self:DumpInt(f.locvars[i].endpc, D)
		end
		n = D.strip and 0 or f.sizeupvalues           -- dump upvalue information
		self:DumpInt(n, D)
		for i = 0, n - 1 do
			self:DumpString(f.upvalues[i], D)
		end
	end

	------------------------------------------------------------------------
	-- dump child function prototypes from function prototype
	------------------------------------------------------------------------
	function luaU:DumpFunction(f, p, D)
		local source = f.source
		if source == p or D.strip then source = nil end
		self:DumpString(source, D)
		self:DumpInt(f.lineDefined, D)
		self:DumpInt(f.lastlinedefined, D)
		self:DumpChar(f.nups, D)
		self:DumpChar(f.numparams, D)
		self:DumpChar(f.is_vararg, D)
		self:DumpChar(f.maxstacksize, D)
		self:DumpCode(f, D)
		self:DumpConstants(f, D)
		self:DumpDebug(f, D)
	end

	------------------------------------------------------------------------
	-- dump Lua header section (some sizes hard-coded)
	------------------------------------------------------------------------
	function luaU:DumpHeader(D)
		local h = self:header()
		assert(#h == self.LUAC_HEADERSIZE) -- fixed buffer now an assert
		self:DumpBlock(h, D)
	end

	------------------------------------------------------------------------
	-- make header (from lundump.c)
	-- returns the header string
	------------------------------------------------------------------------
	function luaU:header()
		local x = 1
		return self.LUA_SIGNATURE..
			string.char(
				self.LUAC_VERSION,
				self.LUAC_FORMAT,
				x,                    -- endianness (1=little)
				4,                    -- sizeof(int)
				4,                    -- sizeof(size_t)
				4,                    -- sizeof(Instruction)
				8,                    -- sizeof(lua_Number)
				0)                    -- is lua_Number integral?
	end

	------------------------------------------------------------------------
	-- dump Lua function as precompiled chunk
	-- (lua_State* L, const Proto* f, lua_Writer w, void* data, int strip)
	-- * w, data are created from make_setS, make_setF
	------------------------------------------------------------------------
	function luaU:dump(L, f, w, data, strip)
		local D = {}  -- DumpState
		D.L = L
		D.write = w
		D.data = data
		D.strip = strip
		D.status = 0
		self:DumpHeader(D)
		self:DumpFunction(f, nil, D)
		-- added: for a chunk writer writing to a file, this final call with
		-- nil data is to indicate to the writer to close the file
		D.write(nil, D.data)
		return D.status
	end

	local bit = bit32
	local unpack = table.unpack or unpack

	local stm_lua_bytecode
	local wrap_lua_func
	local stm_lua_func

	-- SETLIST config
	local FIELDS_PER_FLUSH = 50

	-- remap for better lookup
	local OPCODE_RM = {
		-- level 1
		[22] = 18, -- JMP
		[31] = 8, -- FORLOOP
		[33] = 28, -- TFORLOOP
		-- level 2
		[0] = 3, -- MOVE
		[1] = 13, -- LOADK
		[2] = 23, -- LOADBOOL
		[26] = 33, -- TEST
		-- level 3
		[12] = 1, -- ADD
		[13] = 6, -- SUB
		[14] = 10, -- MUL
		[15] = 16, -- DIV
		[16] = 20, -- MOD
		[17] = 26, -- POW
		[18] = 30, -- UNM
		[19] = 36, -- NOT
		-- level 4
		[3] = 0, -- LOADNIL
		[4] = 2, -- GETUPVAL
		[5] = 4, -- GETGLOBAL
		[6] = 7, -- GETTABLE
		[7] = 9, -- SETGLOBAL
		[8] = 12, -- SETUPVAL
		[9] = 14, -- SETTABLE
		[10] = 17, -- NEWTABLE
		[20] = 19, -- LEN
		[21] = 22, -- CONCAT
		[23] = 24, -- EQ
		[24] = 27, -- LT
		[25] = 29, -- LE
		[27] = 32, -- TESTSET
		[32] = 34, -- FORPREP
		[34] = 37, -- SETLIST
		-- level 5
		[11] = 5, -- SELF
		[28] = 11, -- CALL
		[29] = 15, -- TAILCALL
		[30] = 21, -- RETURN
		[35] = 25, -- CLOSE
		[36] = 31, -- CLOSURE
		[37] = 35, -- VARARG
	}

	-- opcode types for getting values
	local OPCODE_T = {
		[0] = 'ABC',
		'ABx',
		'ABC',
		'ABC',
		'ABC',
		'ABx',
		'ABC',
		'ABx',
		'ABC',
		'ABC',
		'ABC',
		'ABC',
		'ABC',
		'ABC',
		'ABC',
		'ABC',
		'ABC',
		'ABC',
		'ABC',
		'ABC',
		'ABC',
		'ABC',
		'AsBx',
		'ABC',
		'ABC',
		'ABC',
		'ABC',
		'ABC',
		'ABC',
		'ABC',
		'ABC',
		'AsBx',
		'AsBx',
		'ABC',
		'ABC',
		'ABC',
		'ABx',
		'ABC',
	}

	local OPCODE_M = {
		[0] = {b = 'OpArgR', c = 'OpArgN'},
		{b = 'OpArgK', c = 'OpArgN'},
		{b = 'OpArgU', c = 'OpArgU'},
		{b = 'OpArgR', c = 'OpArgN'},
		{b = 'OpArgU', c = 'OpArgN'},
		{b = 'OpArgK', c = 'OpArgN'},
		{b = 'OpArgR', c = 'OpArgK'},
		{b = 'OpArgK', c = 'OpArgN'},
		{b = 'OpArgU', c = 'OpArgN'},
		{b = 'OpArgK', c = 'OpArgK'},
		{b = 'OpArgU', c = 'OpArgU'},
		{b = 'OpArgR', c = 'OpArgK'},
		{b = 'OpArgK', c = 'OpArgK'},
		{b = 'OpArgK', c = 'OpArgK'},
		{b = 'OpArgK', c = 'OpArgK'},
		{b = 'OpArgK', c = 'OpArgK'},
		{b = 'OpArgK', c = 'OpArgK'},
		{b = 'OpArgK', c = 'OpArgK'},
		{b = 'OpArgR', c = 'OpArgN'},
		{b = 'OpArgR', c = 'OpArgN'},
		{b = 'OpArgR', c = 'OpArgN'},
		{b = 'OpArgR', c = 'OpArgR'},
		{b = 'OpArgR', c = 'OpArgN'},
		{b = 'OpArgK', c = 'OpArgK'},
		{b = 'OpArgK', c = 'OpArgK'},
		{b = 'OpArgK', c = 'OpArgK'},
		{b = 'OpArgR', c = 'OpArgU'},
		{b = 'OpArgR', c = 'OpArgU'},
		{b = 'OpArgU', c = 'OpArgU'},
		{b = 'OpArgU', c = 'OpArgU'},
		{b = 'OpArgU', c = 'OpArgN'},
		{b = 'OpArgR', c = 'OpArgN'},
		{b = 'OpArgR', c = 'OpArgN'},
		{b = 'OpArgN', c = 'OpArgU'},
		{b = 'OpArgU', c = 'OpArgU'},
		{b = 'OpArgN', c = 'OpArgN'},
		{b = 'OpArgU', c = 'OpArgN'},
		{b = 'OpArgU', c = 'OpArgN'},
	}

	-- int rd_int_basic(string src, int s, int e, int d)
	-- @src - Source binary string
	-- @s - Start index of a little endian integer
	-- @e - End index of the integer
	-- @d - Direction of the loop
	local function rd_int_basic(src, s, e, d)
		local num = 0

		-- if bb[l] > 127 then -- signed negative
		-- 	num = num - 256 ^ l
		-- 	bb[l] = bb[l] - 128
		-- end

		for i = s, e, d do num = num + string.byte(src, i, i) * 256 ^ (i - s) end

		return num
	end

	-- float rd_flt_basic(byte f1..8)
	-- @f1..4 - The 4 bytes composing a little endian float
	local function rd_flt_basic(f1, f2, f3, f4)
		local sign = (-1) ^ bit.rshift(f4, 7)
		local exp = bit.rshift(f3, 7) + bit.lshift(bit.band(f4, 0x7F), 1)
		local frac = f1 + bit.lshift(f2, 8) + bit.lshift(bit.band(f3, 0x7F), 16)
		local normal = 1

		if exp == 0 then
			if frac == 0 then
				return sign * 0
			else
				normal = 0
				exp = 1
			end
		elseif exp == 0x7F then
			if frac == 0 then
				return sign * (1 / 0)
			else
				return sign * (0 / 0)
			end
		end

		return sign * 2 ^ (exp - 127) * (1 + normal / 2 ^ 23)
	end

	-- double rd_dbl_basic(byte f1..8)
	-- @f1..8 - The 8 bytes composing a little endian double
	local function rd_dbl_basic(f1, f2, f3, f4, f5, f6, f7, f8)
		local sign = (-1) ^ bit.rshift(f8, 7)
		local exp = bit.lshift(bit.band(f8, 0x7F), 4) + bit.rshift(f7, 4)
		local frac = bit.band(f7, 0x0F) * 2 ^ 48
		local normal = 1

		frac = frac + (f6 * 2 ^ 40) + (f5 * 2 ^ 32) + (f4 * 2 ^ 24) + (f3 * 2 ^ 16) + (f2 * 2 ^ 8) + f1 -- help

		if exp == 0 then
			if frac == 0 then
				return sign * 0
			else
				normal = 0
				exp = 1
			end
		elseif exp == 0x7FF then
			if frac == 0 then
				return sign * (1 / 0)
			else
				return sign * (0 / 0)
			end
		end

		return sign * 2 ^ (exp - 1023) * (normal + frac / 2 ^ 52)
	end

	-- int rd_int_le(string src, int s, int e)
	-- @src - Source binary string
	-- @s - Start index of a little endian integer
	-- @e - End index of the integer
	local function rd_int_le(src, s, e) return rd_int_basic(src, s, e - 1, 1) end

	-- int rd_int_be(string src, int s, int e)
	-- @src - Source binary string
	-- @s - Start index of a big endian integer
	-- @e - End index of the integer
	local function rd_int_be(src, s, e) return rd_int_basic(src, e - 1, s, -1) end

	-- float rd_flt_le(string src, int s)
	-- @src - Source binary string
	-- @s - Start index of little endian float
	local function rd_flt_le(src, s) return rd_flt_basic(string.byte(src, s, s + 3)) end

	-- float rd_flt_be(string src, int s)
	-- @src - Source binary string
	-- @s - Start index of big endian float
	local function rd_flt_be(src, s)
		local f1, f2, f3, f4 = string.byte(src, s, s + 3)
		return rd_flt_basic(f4, f3, f2, f1)
	end

	-- double rd_dbl_le(string src, int s)
	-- @src - Source binary string
	-- @s - Start index of little endian double
	local function rd_dbl_le(src, s) return rd_dbl_basic(string.byte(src, s, s + 7)) end

	-- double rd_dbl_be(string src, int s)
	-- @src - Source binary string
	-- @s - Start index of big endian double
	local function rd_dbl_be(src, s)
		local f1, f2, f3, f4, f5, f6, f7, f8 = string.byte(src, s, s + 7) -- same
		return rd_dbl_basic(f8, f7, f6, f5, f4, f3, f2, f1)
	end

	-- to avoid nested ifs in deserializing
	local float_types = {
		[4] = {little = rd_flt_le, big = rd_flt_be},
		[8] = {little = rd_dbl_le, big = rd_dbl_be},
	}

	-- byte stm_byte(Stream S)
	-- @S - Stream object to read from
	local function stm_byte(S)
		local idx = S.index
		local bt = string.byte(S.source, idx, idx)

		S.index = idx + 1
		return bt
	end

	-- string stm_string(Stream S, int len)
	-- @S - Stream object to read from
	-- @len - Length of string being read
	local function stm_string(S, len)
		local pos = S.index + len
		local str = string.sub(S.source, S.index, pos - 1)

		S.index = pos
		return str
	end

	-- string stm_lstring(Stream S)
	-- @S - Stream object to read from
	local function stm_lstring(S)
		local len = S:s_szt()
		local str

		if len ~= 0 then str = string.sub(stm_string(S, len), 1, -2) end

		return str
	end

	-- fn cst_int_rdr(string src, int len, fn func)
	-- @len - Length of type for reader
	-- @func - Reader callback
	local function cst_int_rdr(len, func)
		return function(S)
			local pos = S.index + len
			local int = func(S.source, S.index, pos)
			S.index = pos

			return int
		end
	end

	-- fn cst_flt_rdr(string src, int len, fn func)
	-- @len - Length of type for reader
	-- @func - Reader callback
	local function cst_flt_rdr(len, func)
		return function(S)
			local flt = func(S.source, S.index)
			S.index = S.index + len

			return flt
		end
	end

	local function stm_instructions(S)
		local size = S:s_int()
		local code = {}

		for i = 1, size do
			local ins = S:s_ins()
			local op = bit.band(ins, 0x3F)
			local args = OPCODE_T[op]
			local mode = OPCODE_M[op]
			local data = {value = ins, op = OPCODE_RM[op], A = bit.band(bit.rshift(ins, 6), 0xFF)}

			if args == 'ABC' then
				data.B = bit.band(bit.rshift(ins, 23), 0x1FF)
				data.C = bit.band(bit.rshift(ins, 14), 0x1FF)
				data.is_KB = mode.b == 'OpArgK' and data.B > 0xFF -- post process optimization
				data.is_KC = mode.c == 'OpArgK' and data.C > 0xFF
			elseif args == 'ABx' then
				data.Bx = bit.band(bit.rshift(ins, 14), 0x3FFFF)
				data.is_K = mode.b == 'OpArgK'
			elseif args == 'AsBx' then
				data.sBx = bit.band(bit.rshift(ins, 14), 0x3FFFF) - 131071
			end

			code[i] = data
		end

		return code
	end

	local function stm_constants(S)
		local size = S:s_int()
		local consts = {}

		for i = 1, size do
			local tt = stm_byte(S)
			local k

			if tt == 1 then
				k = stm_byte(S) ~= 0
			elseif tt == 3 then
				k = S:s_num()
			elseif tt == 4 then
				k = stm_lstring(S)
			end

			consts[i] = k -- offset +1 during instruction decode
		end

		return consts
	end

	local function stm_subfuncs(S, src)
		local size = S:s_int()
		local sub = {}

		for i = 1, size do
			sub[i] = stm_lua_func(S, src) -- offset +1 in CLOSURE
		end

		return sub
	end

	local function stm_lineinfo(S)
		local size = S:s_int()
		local lines = {}

		for i = 1, size do lines[i] = S:s_int() end

		return lines
	end

	local function stm_locvars(S)
		local size = S:s_int()
		local locvars = {}

		for i = 1, size do locvars[i] = {varname = stm_lstring(S), startpc = S:s_int(), endpc = S:s_int()} end

		return locvars
	end

	local function stm_upvals(S)
		local size = S:s_int()
		local upvals = {}

		for i = 1, size do upvals[i] = stm_lstring(S) end

		return upvals
	end

	function stm_lua_func(S, psrc)
		local proto = {}
		local src = stm_lstring(S) or psrc -- source is propagated

		proto.source = src -- source name

		S:s_int() -- line defined
		S:s_int() -- last line defined

		proto.numupvals = stm_byte(S) -- num upvalues
		proto.numparams = stm_byte(S) -- num params

		stm_byte(S) -- vararg flag
		stm_byte(S) -- max stack size

		proto.code = stm_instructions(S)
		proto.const = stm_constants(S)
		proto.subs = stm_subfuncs(S, src)
		proto.lines = stm_lineinfo(S)

		stm_locvars(S)
		stm_upvals(S)

		-- post process optimization
		for _, v in ipairs(proto.code) do
			if v.is_K then
				v.const = proto.const[v.Bx + 1] -- offset for 1 based index
			else
				if v.is_KB then v.const_B = proto.const[v.B - 0xFF] end

				if v.is_KC then v.const_C = proto.const[v.C - 0xFF] end
			end
		end

		return proto
	end

	function stm_lua_bytecode(src)
		-- func reader
		local rdr_func

		-- header flags
		local little
		local size_int
		local size_szt
		local size_ins
		local size_num
		local flag_int

		-- stream object
		local stream = {
			-- data
			index = 1,
			source = src,
		}

		assert(stm_string(stream, 4) == '\27Lua', 'invalid Lua signature')
		assert(stm_byte(stream) == 0x51, 'invalid Lua version')
		assert(stm_byte(stream) == 0, 'invalid Lua format')

		little = stm_byte(stream) ~= 0
		size_int = stm_byte(stream)
		size_szt = stm_byte(stream)
		size_ins = stm_byte(stream)
		size_num = stm_byte(stream)
		flag_int = stm_byte(stream) ~= 0

		rdr_func = little and rd_int_le or rd_int_be
		stream.s_int = cst_int_rdr(size_int, rdr_func)
		stream.s_szt = cst_int_rdr(size_szt, rdr_func)
		stream.s_ins = cst_int_rdr(size_ins, rdr_func)

		if flag_int then
			stream.s_num = cst_int_rdr(size_num, rdr_func)
		elseif float_types[size_num] then
			stream.s_num = cst_flt_rdr(size_num, float_types[size_num][little and 'little' or 'big'])
		else
			error('unsupported float size')
		end

		return stm_lua_func(stream, '@virtual')
	end

	local function close_lua_upvalues(list, index)
		for i, uv in pairs(list) do
			if uv.index >= index then
				uv.value = uv.store[uv.index] -- store value
				uv.store = uv
				uv.index = 'value' -- self reference
				list[i] = nil
			end
		end
	end

	local function open_lua_upvalue(list, index, stack)
		local prev = list[index]

		if not prev then
			prev = {index = index, store = stack}
			list[index] = prev
		end

		return prev
	end

	local function wrap_lua_variadic(...) return select('#', ...), {...} end

	local function on_lua_error(exst, err)
		local src = exst.source
		local line = exst.lines[exst.pc - 1]
		local psrc, pline, pmsg = string.match(err or '', '^(.-):(%d+):%s+(.+)')
		local fmt = '%s:%i: [%s:%i] %s'

		line = line or '0'
		psrc = psrc or '?'
		pline = pline or '0'
		pmsg = pmsg or err or ''

		error(string.format(fmt, src, line, psrc, pline, pmsg), 0)
	end

	local function exec_lua_func(exst)
		-- localize for easy lookup
		local code = exst.code
		local subs = exst.subs
		local env = exst.env
		local upvs = exst.upvals
		local vargs = exst.varargs

		-- state variables
		local stktop = -1
		local openupvs = {}
		local stack = exst.stack
		local pc = exst.pc

		while true do
			local inst = code[pc]
			local op = inst.op
			pc = pc + 1

			if op < 18 then
				if op < 8 then
					if op < 3 then
						if op < 1 then
							--[[LOADNIL]]
							for i = inst.A, inst.B do stack[i] = nil end
						elseif op > 1 then
							--[[GETUPVAL]]
							local uv = upvs[inst.B]

							stack[inst.A] = uv.store[uv.index]
						else
							--[[ADD]]
							local lhs, rhs

							if inst.is_KB then
								lhs = inst.const_B
							else
								lhs = stack[inst.B]
							end

							if inst.is_KC then
								rhs = inst.const_C
							else
								rhs = stack[inst.C]
							end

							stack[inst.A] = lhs + rhs
						end
					elseif op > 3 then
						if op < 6 then
							if op > 4 then
								--[[SELF]]
								local A = inst.A
								local B = inst.B
								local index

								if inst.is_KC then
									index = inst.const_C
								else
									index = stack[inst.C]
								end

								stack[A + 1] = stack[B]
								stack[A] = stack[B][index]
							else
								--[[GETGLOBAL]]
								stack[inst.A] = env[inst.const]
							end
						elseif op > 6 then
							--[[GETTABLE]]
							local index

							if inst.is_KC then
								index = inst.const_C
							else
								index = stack[inst.C]
							end

							stack[inst.A] = stack[inst.B][index]
						else
							--[[SUB]]
							local lhs, rhs

							if inst.is_KB then
								lhs = inst.const_B
							else
								lhs = stack[inst.B]
							end

							if inst.is_KC then
								rhs = inst.const_C
							else
								rhs = stack[inst.C]
							end

							stack[inst.A] = lhs - rhs
						end
					else --[[MOVE]]
						stack[inst.A] = stack[inst.B]
					end
				elseif op > 8 then
					if op < 13 then
						if op < 10 then
							--[[SETGLOBAL]]
							env[inst.const] = stack[inst.A]
						elseif op > 10 then
							if op < 12 then
								--[[CALL]]
								local A = inst.A
								local B = inst.B
								local C = inst.C
								local params
								local sz_vals, l_vals

								if B == 0 then
									params = stktop - A
								else
									params = B - 1
								end

								sz_vals, l_vals = wrap_lua_variadic(stack[A](unpack(stack, A + 1, A + params)))

								if C == 0 then
									stktop = A + sz_vals - 1
								else
									sz_vals = C - 1
								end

								for i = 1, sz_vals do stack[A + i - 1] = l_vals[i] end
							else
								--[[SETUPVAL]]
								local uv = upvs[inst.B]

								uv.store[uv.index] = stack[inst.A]
							end
						else
							--[[MUL]]
							local lhs, rhs

							if inst.is_KB then
								lhs = inst.const_B
							else
								lhs = stack[inst.B]
							end

							if inst.is_KC then
								rhs = inst.const_C
							else
								rhs = stack[inst.C]
							end

							stack[inst.A] = lhs * rhs
						end
					elseif op > 13 then
						if op < 16 then
							if op > 14 then
								--[[TAILCALL]]
								local A = inst.A
								local B = inst.B
								local params

								if B == 0 then
									params = stktop - A
								else
									params = B - 1
								end

								close_lua_upvalues(openupvs, 0)
								return wrap_lua_variadic(stack[A](unpack(stack, A + 1, A + params)))
							else
								--[[SETTABLE]]
								local index, value

								if inst.is_KB then
									index = inst.const_B
								else
									index = stack[inst.B]
								end

								if inst.is_KC then
									value = inst.const_C
								else
									value = stack[inst.C]
								end

								stack[inst.A][index] = value
							end
						elseif op > 16 then
							--[[NEWTABLE]]
							stack[inst.A] = {}
						else
							--[[DIV]]
							local lhs, rhs

							if inst.is_KB then
								lhs = inst.const_B
							else
								lhs = stack[inst.B]
							end

							if inst.is_KC then
								rhs = inst.const_C
							else
								rhs = stack[inst.C]
							end

							stack[inst.A] = lhs / rhs
						end
					else
						--[[LOADK]]
						stack[inst.A] = inst.const
					end
				else
					--[[FORLOOP]]
					local A = inst.A
					local step = stack[A + 2]
					local index = stack[A] + step
					local limit = stack[A + 1]
					local loops

					if step == math.abs(step) then
						loops = index <= limit
					else
						loops = index >= limit
					end

					if loops then
						stack[inst.A] = index
						stack[inst.A + 3] = index
						pc = pc + inst.sBx
					end
				end
			elseif op > 18 then
				if op < 28 then
					if op < 23 then
						if op < 20 then
							--[[LEN]]
							stack[inst.A] = #stack[inst.B]
						elseif op > 20 then
							if op < 22 then
								--[[RETURN]]
								local A = inst.A
								local B = inst.B
								local vals = {}
								local size

								if B == 0 then
									size = stktop - A + 1
								else
									size = B - 1
								end

								for i = 1, size do vals[i] = stack[A + i - 1] end

								close_lua_upvalues(openupvs, 0)
								return size, vals
							else
								--[[CONCAT]]
								local str = stack[inst.B]

								for i = inst.B + 1, inst.C do str = str .. stack[i] end

								stack[inst.A] = str
							end
						else
							--[[MOD]]
							local lhs, rhs

							if inst.is_KB then
								lhs = inst.const_B
							else
								lhs = stack[inst.B]
							end

							if inst.is_KC then
								rhs = inst.const_C
							else
								rhs = stack[inst.C]
							end

							stack[inst.A] = lhs % rhs
						end
					elseif op > 23 then
						if op < 26 then
							if op > 24 then
								--[[CLOSE]]
								close_lua_upvalues(openupvs, inst.A)
							else
								--[[EQ]]
								local lhs, rhs

								if inst.is_KB then
									lhs = inst.const_B
								else
									lhs = stack[inst.B]
								end

								if inst.is_KC then
									rhs = inst.const_C
								else
									rhs = stack[inst.C]
								end

								if (lhs == rhs) == (inst.A ~= 0) then pc = pc + code[pc].sBx end

								pc = pc + 1
							end
						elseif op > 26 then
							--[[LT]]
							local lhs, rhs

							if inst.is_KB then
								lhs = inst.const_B
							else
								lhs = stack[inst.B]
							end

							if inst.is_KC then
								rhs = inst.const_C
							else
								rhs = stack[inst.C]
							end

							if (lhs < rhs) == (inst.A ~= 0) then pc = pc + code[pc].sBx end

							pc = pc + 1
						else
							--[[POW]]
							local lhs, rhs

							if inst.is_KB then
								lhs = inst.const_B
							else
								lhs = stack[inst.B]
							end

							if inst.is_KC then
								rhs = inst.const_C
							else
								rhs = stack[inst.C]
							end

							stack[inst.A] = lhs ^ rhs
						end
					else
						--[[LOADBOOL]]
						stack[inst.A] = inst.B ~= 0

						if inst.C ~= 0 then pc = pc + 1 end
					end
				elseif op > 28 then
					if op < 33 then
						if op < 30 then
							--[[LE]]
							local lhs, rhs

							if inst.is_KB then
								lhs = inst.const_B
							else
								lhs = stack[inst.B]
							end

							if inst.is_KC then
								rhs = inst.const_C
							else
								rhs = stack[inst.C]
							end

							if (lhs <= rhs) == (inst.A ~= 0) then pc = pc + code[pc].sBx end

							pc = pc + 1
						elseif op > 30 then
							if op < 32 then
								--[[CLOSURE]]
								local sub = subs[inst.Bx + 1] -- offset for 1 based index
								local nups = sub.numupvals
								local uvlist

								if nups ~= 0 then
									uvlist = {}

									for i = 1, nups do
										local pseudo = code[pc + i - 1]

										if pseudo.op == OPCODE_RM[0] then -- @MOVE
											uvlist[i - 1] = open_lua_upvalue(openupvs, pseudo.B, stack)
										elseif pseudo.op == OPCODE_RM[4] then -- @GETUPVAL
											uvlist[i - 1] = upvs[pseudo.B]
										end
									end

									pc = pc + nups
								end

								stack[inst.A] = wrap_lua_func(sub, env, uvlist)
							else
								--[[TESTSET]]
								local A = inst.A
								local B = inst.B

								if (not stack[B]) == (inst.C ~= 0) then
									pc = pc + 1
								else
									stack[A] = stack[B]
								end
							end
						else
							--[[UNM]]
							stack[inst.A] = -stack[inst.B]
						end
					elseif op > 33 then
						if op < 36 then
							if op > 34 then
								--[[VARARG]]
								local A = inst.A
								local size = inst.B

								if size == 0 then
									size = vargs.size
									stktop = A + size - 1
								end

								for i = 1, size do stack[A + i - 1] = vargs.list[i] end
							else
								--[[FORPREP]]
								local A = inst.A
								local init, limit, step

								init = assert(tonumber(stack[A]), '`for` initial value must be a number')
								limit = assert(tonumber(stack[A + 1]), '`for` limit must be a number')
								step = assert(tonumber(stack[A + 2]), '`for` step must be a number')

								stack[A] = init - step
								stack[A + 1] = limit
								stack[A + 2] = step

								pc = pc + inst.sBx
							end
						elseif op > 36 then
							--[[SETLIST]]
							local A = inst.A
							local C = inst.C
							local size = inst.B
							local tab = stack[A]
							local offset

							if size == 0 then size = stktop - A end

							if C == 0 then
								C = inst[pc].value
								pc = pc + 1
							end

							offset = (C - 1) * FIELDS_PER_FLUSH

							for i = 1, size do tab[i + offset] = stack[A + i] end
						else
							--[[NOT]]
							stack[inst.A] = not stack[inst.B]
						end
					else
						--[[TEST]]
						if (not stack[inst.A]) == (inst.C ~= 0) then pc = pc + 1 end
					end
				else
					--[[TFORLOOP]]
					local A = inst.A
					local func = stack[A]
					local state = stack[A + 1]
					local index = stack[A + 2]
					local base = A + 3
					local vals

					stack[base + 2] = index
					stack[base + 1] = state
					stack[base] = func

					vals = {func(state, index)}

					for i = 1, inst.C do stack[base + i - 1] = vals[i] end

					if stack[base] ~= nil then
						stack[A + 2] = stack[base]
					else
						pc = pc + 1
					end
				end
			else
				--[[JMP]]
				pc = pc + inst.sBx
			end

			exst.pc = pc
		end
	end

	function wrap_lua_func(state, env, upvals)
		local st_code = state.code
		local st_subs = state.subs
		local st_lines = state.lines
		local st_source = state.source
		local st_numparams = state.numparams

		local function exec_wrap(...)
			local stack = {}
			local varargs = {}
			local sizevarg = 0
			local sz_args, l_args = wrap_lua_variadic(...)

			local exst
			local ok, err, vals

			for i = 1, st_numparams do stack[i - 1] = l_args[i] end

			if st_numparams < sz_args then
				sizevarg = sz_args - st_numparams
				for i = 1, sizevarg do varargs[i] = l_args[st_numparams + i] end
			end

			exst = {
				varargs = {list = varargs, size = sizevarg},
				code = st_code,
				subs = st_subs,
				lines = st_lines,
				source = st_source,
				env = env,
				upvals = upvals,
				stack = stack,
				pc = 1,
			}

			ok, err, vals = pcall(exec_lua_func, exst, ...)

			if ok then
				return unpack(vals, 1, err)
			else
				on_lua_error(exst, err)
			end

			return -- explicit "return nothing"
		end

		return exec_wrap
	end

	local fiOne = function(BCode, Env)
		return wrap_lua_func(stm_lua_bytecode(BCode), Env or {})
	end

--[[
	Description: A virtual enviroment implementation to replace the legacy function enviroments
	Author: github@ccuser44/ALE111_boiPNG
	Date: 15.2.2022
--]]

	type dictionary = { [string]: any }
	type func = (...any?) -> (...any?)

	local globalEnv: dictionary = {
		-- // Libraries
		coroutine = coroutine,
		debug = debug,
		math = math,
		os = os,
		string = string,
		table = table,
		utf8 = utf8,
		bit32 = bit32,
		task = task,

		-- // Lua globals
		assert = assert,
		collectgarbage = function(action: string): number -- Use gcinfo instead
			assert(type(action) == "string", "invalid argument #1 to 'collectgarbage' (string expected, got "..type(action)..")")
			assert(action == "count", "collectgarbage must be called with 'count'; use gcinfo() instead")

			return gcinfo()
		end,
		error = error,
		getmetatable = getmetatable,
		ipairs = ipairs,
		newproxy = newproxy,
		next = next,
		pairs = pairs,
		pcall = pcall,
		print = print,
		rawequal = rawequal,
		rawget = rawget,
		rawset = rawset,
		select = select,
		setmetatable = setmetatable,
		tonumber = tonumber,
		tostring = tostring,
		type = type,
		unpack = unpack,
		xpcall = xpcall,
		warn = warn,
		gcinfo = gcinfo,
		_G = _G,
		_VERSION = _VERSION,

		-- // Roblox globals
		settings = settings,
		time = time,
		typeof = typeof,
		UserSettings = UserSettings,
		require = require,
		game = game,
		workspace = workspace,
		shared = shared,

		-- // Deprecated Roblox globals (Please don't use, use the alternative instead)
		delay = task.delay,-- Use task.delay instead
		spawn = task.defer,-- Use task.spawn instead
		wait = task.wait,-- Use task.wait instead
		elapsedTime = os.clock,-- Use os.clock instead
		stats = function(): Stats
			return game:GetService("Stats")
		end,-- Use game:GetService("Stats") instead
		tick = tick,-- Use os.time or os.clock instead

		-- // Roblox datatypes
		Axes = Axes,
		BrickColor = BrickColor,
		CatalogSearchParams = CatalogSearchParams,
		CFrame = CFrame,
		Color3 = Color3,
		ColorSequence = ColorSequence,
		ColorSequenceKeypoint = ColorSequenceKeypoint,
		DateTime = DateTime,
		DockWidgetPluginGuiInfo = DockWidgetPluginGuiInfo,
		Enum = Enum,
		Faces = Faces,
		FloatCurveKey = FloatCurveKey,
		Instance = Instance,
		NumberRange = NumberRange,
		NumberSequence = NumberSequence,
		NumberSequenceKeypoint = NumberSequenceKeypoint,
		OverlapParams = OverlapParams,
		PathWaypoint = PathWaypoint,
		PhysicalProperties = PhysicalProperties,
		Random = Random,
		Ray = Ray,
		RaycastParams = RaycastParams,
		Rect = Rect,
		Region3 = Region3,
		Region3int16 = Region3int16,
		TweenInfo = TweenInfo,
		UDim = UDim,
		UDim2 = UDim2,
		Vector2 = Vector2,
		Vector2int16 = Vector2int16,
		Vector3 = Vector3,
		Vector3int16 = Vector3int16,
	}

	table.freeze(globalEnv)

	local virtualEnv = function()
		local env: dictionary = {}

		for k, v in pairs(globalEnv) do
			env[k] = v
		end

		env._ENV = env :: dictionary

		env["getf".."env"] = function(target: (func | number)?): dictionary
			assert(type(target) == "number" or type(target) == "function" or type(target) == "nil", "invalid argument #1 to 'setf".."env' (number expected, got "..type(target)..")")
			assert(type(target) == "number" and target >= 0 or type(target) ~= "number", "invalid argument #1 to 'setf".."env' (level must be non-negative)")

			return env
		end

		env["setf".."env"] = function(target: func | number, newEnv: dictionary): ()
			assert(type(newEnv) == "table", "invalid argument #2 to 'setf".."env' (table expected, got "..type(newEnv)..")")
			assert(type(target) == "number" or type(target) == "function", "invalid argument #1 to 'setf".."env' (number expected, got "..type(target)..")")
			assert(type(target) == "number" and target >= 0, "invalid argument #1 to 'setf".."env' (level must be non-negative)")

			table.clear(env)

			for k: string, v: any in pairs(newEnv) do
				if type(k) == "string" then
					env[k] = v
				end
			end
		end

		-- // Stupid luau linter cant even recognise a metatable
		setmetatable(env, table.freeze({
			__index = globalEnv,
			__metatable = "The metatable is locked"
		}))

		return env
	end

	vEnv = virtualEnv()

	luaX:init()
	local LuaState = {}

	return function(str, env)
		local f,writer,buff,name
		local env = if env ~= nil then env elseif vEnv ~= nil then vEnv else {}
		local name = (env and env.script and env.script:GetFullName())
		local ran,error = pcall(function()
			local zio = luaZ:init(luaZ:make_getS(str), nil)
			if not zio then return error() end
			local func = luaY:parser(LuaState, zio, nil, name or "@input")
			writer, buff = luaU:make_setS()
			luaU:dump(LuaState, func, writer, buff)
			f = fiOne(buff.data, env)
		end)

		if ran then
			return f,buff.data
		else
			return nil,error
		end
	end
end

local xmlModule = function()
	--- @module Module providing a non-validating XML stream parser in Lua.
	--
	--  Features:
	--  =========
	--
	--      * Tokenises well-formed XML (relatively robustly)
	--      * Flexible handler based event API (see below)
	--      * Parses all XML Infoset elements - ie.
	--          - Tags
	--          - Text
	--          - Comments
	--          - CDATA
	--          - XML Decl
	--          - Processing Instructions
	--          - DOCTYPE declarations
	--      * Provides limited well-formedness checking
	--        (checks for basic syntax & balanced tags only)
	--      * Flexible whitespace handling (selectable)
	--      * Entity Handling (selectable)
	--
	--  Limitations:
	--  ============
	--
	--      * Non-validating
	--      * No charset handling
	--      * No namespace support
	--      * Shallow well-formedness checking only (fails
	--        to detect most semantic errors)
	--
	--  API:
	--  ====
	--
	--  The parser provides a partially object-oriented API with
	--  functionality split into tokeniser and handler components.
	--
	--  The handler instance is passed to the tokeniser and receives
	--  callbacks for each XML element processed (if a suitable handler
	--  function is defined). The API is conceptually similar to the
	--  SAX API but implemented differently.
	--
	--  XML data is passed to the parser instance through the 'parse'
	--  method (Note: must be passed a single string currently)
	--
	--  License:
	--  ========
	--
	--      This code is freely distributable under the terms of the [MIT license](LICENSE).
	--
	--
	--@author Paul Chakravarti (paulc@passtheaardvark.com)
	--@author Manoel Campos da Silva Filho
	local xml2lua = { _VERSION = "1.6-1" }

	--- @module Class providing the actual XML parser.
	--  Available options are:
	--      * stripWS   
	--        Strip non-significant whitespace (leading/trailing) 
	--        and do not generate events for empty text elements
	--  
	--      * expandEntities 
	--        Expand entities (standard entities + single char 
	--        numeric entities only currently - could be extended 
	--        at runtime if suitable DTD parser added elements
	--        to table (see obj._ENTITIES). May also be possible
	--        to expand multibyre entities for UTF-8 only
	--  
	--      * errorHandler
	--        Custom error handler function 
	--
	--  NOTE: Boolean options must be set to 'nil' not '0'

	---Converts the decimal code of a character to its corresponding char
	--if it's a graphical char, otherwise, returns the HTML ISO code
	--for that decimal value in the format &#code
	--@param code the decimal value to convert to its respective character
	local function decimalToHtmlChar(code)
		local num = tonumber(code)
		if num >= 0 and num < 256 then
			return string.char(num)
		end

		return "&#"..code..";"
	end

	---Converts the hexadecimal code of a character to its corresponding char
	--if it's a graphical char, otherwise, returns the HTML ISO code
	--for that hexadecimal value in the format &#xCode
	--@param code the hexadecimal value to convert to its respective character
	local function hexadecimalToHtmlChar(code)
		local num = tonumber(code, 16)
		if num >= 0 and num < 256 then
			return string.char(num)
		end

		return "&#x"..code..";"
	end

	local XmlParser = {
		-- Private attributes/functions
		_XML        = '^([^<]*)<(%/?)([^>]-)(%/?)>',
		_ATTR1      = '([%w-:_]+)%s*=%s*"(.-)"',
		_ATTR2      = '([%w-:_]+)%s*=%s*\'(.-)\'',
		_CDATA      = '<%!%[CDATA%[(.-)%]%]>',
		_PI         = '<%?(.-)%?>',
		_COMMENT    = '<!%-%-(.-)%-%->',
		_TAG        = '^(.-)%s.*',
		_LEADINGWS  = '^%s+',
		_TRAILINGWS = '%s+$',
		_WS         = '^%s*$',
		_DTD1       = '<!DOCTYPE%s+(.-)%s+(SYSTEM)%s+["\'](.-)["\']%s*(%b[])%s*>',
		_DTD2       = '<!DOCTYPE%s+(.-)%s+(PUBLIC)%s+["\'](.-)["\']%s+["\'](.-)["\']%s*(%b[])%s*>',
		_DTD3       = '<!DOCTYPE%s+(.-)%s+%[%s+.-%]>', -- Inline DTD Schema
		_DTD4       = '<!DOCTYPE%s+(.-)%s+(SYSTEM)%s+["\'](.-)["\']%s*>',
		_DTD5       = '<!DOCTYPE%s+(.-)%s+(PUBLIC)%s+["\'](.-)["\']%s+["\'](.-)["\']%s*>',
		_DTD6       = '<!DOCTYPE%s+(.-)%s+(PUBLIC)%s+["\'](.-)["\']%s*>',

		--Matches an attribute with non-closing double quotes (The equal sign is matched non-greedly by using =+?)
		_ATTRERR1   = '=+?%s*"[^"]*$',
		--Matches an attribute with non-closing single quotes (The equal sign is matched non-greedly by using =+?)
		_ATTRERR2   = '=+?%s*\'[^\']*$',
		--Matches a closing tag such as </person> or the end of a openning tag such as <person>
		_TAGEXT     = '(%/?)>',

		_errstr = { 
			xmlErr = "Error Parsing XML",
			declErr = "Error Parsing XMLDecl",
			declStartErr = "XMLDecl not at start of document",
			declAttrErr = "Invalid XMLDecl attributes",
			piErr = "Error Parsing Processing Instruction",
			commentErr = "Error Parsing Comment",
			cdataErr = "Error Parsing CDATA",
			dtdErr = "Error Parsing DTD",
			endTagErr = "End Tag Attributes Invalid",
			unmatchedTagErr = "Unbalanced Tag",
			incompleteXmlErr = "Incomplete XML Document",
		},

		_ENTITIES = { 
			["&lt;"] = "<",
			["&gt;"] = ">",
			["&amp;"] = "&",
			["&quot;"] = '"',
			["&apos;"] = "'",
			["&#(%d+);"] = decimalToHtmlChar,
			["&#x(%x+);"] = hexadecimalToHtmlChar,
		},
	}

	--- Instantiates a XmlParser object.
	--@param _handler Handler module to be used to convert the XML string
	--               to another formats. See the available handlers at the handler directory.
	--               Usually you get an instance to a handler module using, for instance:
	--               local handler = require("xmlhandler/tree").
	--@param _options Options for this XmlParser instance.
	--@see XmlParser.options
	function XmlParser.new(_handler, _options)
		local obj = {
			handler = _handler,
			options = _options,
			_stack  = {}
		}

		setmetatable(obj, XmlParser)
		obj.__index = XmlParser
		return obj;
	end

	---Checks if a function/field exists in a table or in its metatable
	--@param table the table to check if it has a given function
	--@param elementName the name of the function/field to check if exists
	--@return true if the function/field exists, false otherwise
	local function fexists(table, elementName)
		if table == nil then
			return false
		end

		if table[elementName] == nil then
			return fexists(getmetatable(table), elementName)
		else
			return true
		end
	end

	local function err(self, errMsg, pos)
		if self.options.errorHandler then
			self.options.errorHandler(errMsg,pos)
		end
	end

	--- Removes whitespaces
	local function stripWS(self, s)
		if self.options.stripWS then
			s = string.gsub(s,'^%s+','')
			s = string.gsub(s,'%s+$','')
		end
		return s
	end

	local function parseEntities(self, s) 
		if self.options.expandEntities then
			for k,v in pairs(self._ENTITIES) do
				s = string.gsub(s,k,v)
			end
		end

		return s
	end

	--- Parses a string representing a tag.
	--@param s String containing tag text
	--@return a {name, attrs} table
	-- where name is the name of the tag and attrs 
	-- is a table containing the attributes of the tag
	local function parseTag(self, s)
		local tag = {
			name = string.gsub(s, self._TAG, '%1'),
			attrs = {}
		}            

		local parseFunction = function (k, v) 
			tag.attrs[k] = parseEntities(self, v)
			tag.attrs._ = 1 
		end

		string.gsub(s, self._ATTR1, parseFunction) 
		string.gsub(s, self._ATTR2, parseFunction)

		if tag.attrs._ then
			tag.attrs._ = nil
		else 
			tag.attrs = nil
		end

		return tag
	end

	local function parseXmlDeclaration(self, xml, f)
		-- XML Declaration
		f.match, f.endMatch, f.text = string.find(xml, self._PI, f.pos)
		if not f.match then 
			err(self, self._errstr.declErr, f.pos)
		end 

		if f.match ~= 1 then
			-- Must be at start of doc if present
			err(self, self._errstr.declStartErr, f.pos)
		end

		local tag = parseTag(self, f.text) 
		-- TODO: Check if attributes are valid
		-- Check for version (mandatory)
		if tag.attrs and tag.attrs.version == nil then
			err(self, self._errstr.declAttrErr, f.pos)
		end

		if fexists(self.handler, 'decl') then 
			self.handler:decl(tag, f.match, f.endMatch)
		end    

		return tag
	end

	local function parseXmlProcessingInstruction(self, xml, f)
		local tag = {}

		-- XML Processing Instruction (PI)
		f.match, f.endMatch, f.text = string.find(xml, self._PI, f.pos)
		if not f.match then 
			err(self, self._errstr.piErr, f.pos)
		end 
		if fexists(self.handler, 'pi') then 
			-- Parse PI attributes & text
			tag = parseTag(self, f.text) 
			local pi = string.sub(f.text, string.len(tag.name)+1)
			if pi ~= "" then
				if tag.attrs then
					tag.attrs._text = pi
				else
					tag.attrs = { _text = pi }
				end
			end
			self.handler:pi(tag, f.match, f.endMatch) 
		end

		return tag
	end

	local function parseComment(self, xml, f)
		f.match, f.endMatch, f.text = string.find(xml, self._COMMENT, f.pos)
		if not f.match then 
			err(self, self._errstr.commentErr, f.pos)
		end 

		if fexists(self.handler, 'comment') then 
			f.text = parseEntities(self, stripWS(self, f.text))
			self.handler:comment(f.text, next, f.match, f.endMatch)
		end
	end

	local function _parseDtd(self, xml, pos)
		-- match,endMatch,root,type,name,uri,internal
		local dtdPatterns = {self._DTD1, self._DTD2, self._DTD3, self._DTD4, self._DTD5, self._DTD6}

		for _, dtd in pairs(dtdPatterns) do
			local m,e,r,t,n,u,i = string.find(xml, dtd, pos)
			if m then
				return m, e, {_root=r, _type=t, _name=n, _uri=u, _internal=i} 
			end
		end

		return nil
	end

	local function parseDtd(self, xml, f)
		f.match, f.endMatch, _ = _parseDtd(self, xml, f.pos)
		if not f.match then 
			err(self, self._errstr.dtdErr, f.pos)
		end 

		if fexists(self.handler, 'dtd') then
			local tag = {name="DOCTYPE", value=string.sub(xml, f.match+10, f.endMatch-1)}
			self.handler:dtd(tag, f.match, f.endMatch)
		end
	end

	local function parseCdata(self, xml, f)
		f.match, f.endMatch, f.text = string.find(xml, self._CDATA, f.pos)
		if not f.match then 
			err(self, self._errstr.cdataErr, f.pos)
		end 

		if fexists(self.handler, 'cdata') then
			self.handler:cdata(f.text, nil, f.match, f.endMatch)
		end    
	end

	--- Parse a Normal tag
	-- Need check for embedded '>' in attribute value and extend
	-- match recursively if necessary eg. <tag attr="123>456"> 
	local function parseNormalTag(self, xml, f)
		--Check for errors
		while 1 do
			--If there isn't an attribute without closing quotes (single or double quotes)
			--then breaks to follow the normal processing of the tag.
			--Otherwise, try to find where the quotes close.
			f.errStart, f.errEnd = string.find(f.tagstr, self._ATTRERR1)        

			if f.errEnd == nil then
				f.errStart, f.errEnd = string.find(f.tagstr, self._ATTRERR2)
				if f.errEnd == nil then
					break
				end
			end

			f.extStart, f.extEnd, f.endt2 = string.find(xml, self._TAGEXT, f.endMatch+1)
			f.tagstr = f.tagstr .. string.sub(xml, f.endMatch, f.extEnd-1)
			if not f.match then 
				err(self, self._errstr.xmlErr, f.pos)
			end 
			f.endMatch = f.extEnd
		end 

		-- Extract tag name and attrs
		local tag = parseTag(self, f.tagstr) 

		if (f.endt1=="/") then
			if fexists(self.handler, 'endtag') then
				if tag.attrs then
					-- Shouldn't have any attributes in endtag
					err(self, string.format("%s (/%s)", self._errstr.endTagErr, tag.name), f.pos)
				end
				if table.remove(self._stack) ~= tag.name then
					err(self, string.format("%s (/%s)", self._errstr.unmatchedTagErr, tag.name), f.pos)
				end
				self.handler:endtag(tag, f.match, f.endMatch)
			end
		else
			table.insert(self._stack, tag.name)

			if fexists(self.handler, 'starttag') then
				self.handler:starttag(tag, f.match, f.endMatch)
			end

			-- Self-Closing Tag
			if (f.endt2=="/") then
				table.remove(self._stack)
				if fexists(self.handler, 'endtag') then
					self.handler:endtag(tag, f.match, f.endMatch)
				end
			end
		end

		return tag
	end

	local function parseTagType(self, xml, f)
		-- Test for tag type
		if string.find(string.sub(f.tagstr, 1, 5), "?xml%s") then
			parseXmlDeclaration(self, xml, f)
		elseif string.sub(f.tagstr, 1, 1) == "?" then
			parseXmlProcessingInstruction(self, xml, f)
		elseif string.sub(f.tagstr, 1, 3) == "!--" then
			parseComment(self, xml, f)
		elseif string.sub(f.tagstr, 1, 8) == "!DOCTYPE" then
			parseDtd(self, xml, f)
		elseif string.sub(f.tagstr, 1, 8) == "![CDATA[" then
			parseCdata(self, xml, f)
		else
			parseNormalTag(self, xml, f)
		end
	end

	--- Get next tag (first pass - fix exceptions below).
	--@return true if the next tag could be got, false otherwise
	local function getNextTag(self, xml, f)
		f.match, f.endMatch, f.text, f.endt1, f.tagstr, f.endt2 = string.find(xml, self._XML, f.pos)
		if not f.match then 
			if string.find(xml, self._WS, f.pos) then
				-- No more text - check document complete
				if #self._stack ~= 0 then
					err(self, self._errstr.incompleteXmlErr, f.pos)
				else
					return false 
				end
			else
				-- Unparsable text
				err(self, self._errstr.xmlErr, f.pos)
			end
		end 

		f.text = f.text or ''
		f.tagstr = f.tagstr or ''
		f.match = f.match or 0

		return f.endMatch ~= nil
	end

	--Main function which starts the XML parsing process
	--@param xml the XML string to parse
	--@param parseAttributes indicates if tag attributes should be parsed or not. 
	--       If omitted, the default value is true.
	function XmlParser:parse(xml, parseAttributes)
		if type(self) ~= "table" or getmetatable(self) ~= XmlParser then
			error("You must call xmlparser:parse(parameters) instead of xmlparser.parse(parameters)")
		end

		if parseAttributes == nil then
			parseAttributes = true
		end

		self.handler.parseAttributes = parseAttributes

		--Stores string.find results and parameters
		--and other auxiliar variables
		local f = {
			--string.find return
			match = 0,
			endMatch = 0,
			-- text, end1, tagstr, end2,

			--string.find parameters and auxiliar variables
			pos = 1,
			-- startText, endText,
			-- errStart, errEnd, extStart, extEnd,
		}

		while f.match do
			if not getNextTag(self, xml, f) then
				break
			end

			-- Handle leading text
			f.startText = f.match
			f.endText = f.match + string.len(f.text) - 1
			f.match = f.match + string.len(f.text)
			f.text = parseEntities(self, stripWS(self, f.text))
			if f.text ~= "" and fexists(self.handler, 'text') then
				self.handler:text(f.text, nil, f.match, f.endText)
			end

			parseTagType(self, xml, f)
			f.pos = f.endMatch + 1
		end
	end

	XmlParser.__index = XmlParser

	---Recursivelly prints a table in an easy-to-ready format
	--@param tb The table to be printed
	--@param level the indentation level to start with
	local function printableInternal(tb, level)
		if tb == nil then
			return
		end

		level = level or 1
		local spaces = string.rep(' ', level*2)
		for k,v in pairs(tb) do
			if type(v) == "table" then
				print(spaces .. k)
				printableInternal(v, level+1)
			else
				print(spaces .. k..'='..v)
			end
		end
	end

	---Instantiates a XmlParser object to parse a XML string
	--@param handler Handler module to be used to convert the XML string
	--to another formats. See the available handlers at the handler directory.
	-- Usually you get an instance to a handler module using, for instance:
	-- local handler = require("xmlhandler/tree").
	--@return a XmlParser object used to parse the XML
	--@see XmlParser
	function xml2lua.parser(handler)
		if handler == xml2lua then
			error("You must call xml2lua.parse(handler) instead of xml2lua:parse(handler)")
		end

		local options = {
			--Indicates if whitespaces should be striped or not
			stripWS = 1,
			expandEntities = 1,
			errorHandler = function(errMsg, pos)
				error(string.format("%s [char=%d]\n", errMsg or "Parse Error", pos))
			end
		}

		return XmlParser.new(handler, options)
	end

	---Recursivelly prints a table in an easy-to-ready format
	--@param tb The table to be printed
	function xml2lua.printable(tb)
		printableInternal(tb)
	end

	---Handler to generate a string prepresentation of a table
	--Convenience function for printHandler (Does not support recursive tables).
	--@param t Table to be parsed
	--@return a string representation of the table
	function xml2lua.toString(t)
		local sep = ''
		local res = ''
		if type(t) ~= 'table' then
			return t
		end

		for k,v in pairs(t) do
			if type(v) == 'table' then
				v = xml2lua.toString(v)
			end
			res = res .. sep .. string.format("%s=%s", k, v)
			sep = ','
		end
		res = '{'..res..'}'

		return res
	end

	--- Loads an XML file from a specified path
	-- @param xmlFilePath the path for the XML file to load
	-- @return the XML loaded file content
	---Gets an _attr element from a table that represents the attributes of an XML tag,
	--and generates a XML String representing the attibutes to be inserted
	--into the openning tag of the XML
	--
	--@param attrTable table from where the _attr field will be got
	--@return a XML String representation of the tag attributes
	local function attrToXml(attrTable)
		local s = ""
		attrTable = attrTable or {}

		for k, v in pairs(attrTable) do
			s = s .. " " .. k .. "=" .. '"' .. v .. '"'
		end
		return s
	end

	---Gets the first key of a given table
	local function getSingleChild(tb)
		local count = 0
		for _ in pairs(tb) do
			count = count + 1
		end
		if (count == 1) then
			for k, _ in pairs(tb) do
				return k
			end
		end
		return nil
	end

	---Gets the first value of a given table
	local function getFirstValue(tb)
		if type(tb) == "table" then
			for _, v in pairs(tb) do
				return v
			end
			return nil
		end

		return tb
	end

	xml2lua.pretty = true

	function xml2lua.getSpaces(level)
		local spaces = ''
		if (xml2lua.pretty) then
			spaces = string.rep(' ', level * 2)
		end
		return spaces
	end

	function xml2lua.addTagValueAttr(tagName, tagValue, attrTable, level)
		local attrStr = attrToXml(attrTable)
		local spaces = xml2lua.getSpaces(level)
		if (tagValue == '') then
			table.insert(xml2lua.xmltb, spaces .. '<' .. tagName .. attrStr .. '/>')
		else
			table.insert(xml2lua.xmltb, spaces .. '<' .. tagName .. attrStr .. '>' .. tostring(tagValue) .. '</' .. tagName .. '>')
		end
	end

	function xml2lua.startTag(tagName, attrTable, level)
		local attrStr = attrToXml(attrTable)
		local spaces = xml2lua.getSpaces(level)
		if (tagName ~= nil) then
			table.insert(xml2lua.xmltb, spaces .. '<' .. tagName .. attrStr .. '>')
		end
	end

	function xml2lua.endTag(tagName, level)
		local spaces = xml2lua.getSpaces(level)
		if (tagName ~= nil) then
			table.insert(xml2lua.xmltb, spaces .. '</' .. tagName .. '>')
		end
	end

	function xml2lua.isChildArray(obj)
		for tag, _ in pairs(obj) do
			if (type(tag) == 'number') then
				return true
			end
		end
		return false
	end

	function xml2lua.isTableEmpty(obj)
		for k, _ in pairs(obj) do
			if (k ~= '_attr') then
				return false
			end
		end
		return true
	end

	function xml2lua.parseTableToXml(obj, tagName, level)
		if (tagName ~= '_attr') then
			if (type(obj) == 'table') then
				if (xml2lua.isChildArray(obj)) then
					for _, value in pairs(obj) do
						xml2lua.parseTableToXml(value, tagName, level)
					end
				elseif xml2lua.isTableEmpty(obj) then
					xml2lua.addTagValueAttr(tagName, "", obj._attr, level)
				else
					xml2lua.startTag(tagName, obj._attr, level)
					for tag, value in pairs(obj) do
						xml2lua.parseTableToXml(value, tag, level + 1)
					end
					xml2lua.endTag(tagName, level)
				end
			else
				xml2lua.addTagValueAttr(tagName, obj, nil, level)
			end
		end
	end

	---Converts a Lua table to a XML String representation.
	--@param tb Table to be converted to XML
	--@param tableName Name of the table variable given to this function,
	--                 to be used as the root tag. If a value is not provided
	--                 no root tag will be created.
	--@param level Only used internally, when the function is called recursively to print indentation
	--
	--@return a String representing the table content in XML
	function xml2lua.toXml(tb, tableName, level)
		xml2lua.xmltb = {}
		level = level or 0
		local singleChild = getSingleChild(tb)
		tableName = tableName or singleChild

		if (singleChild) then
			xml2lua.parseTableToXml(getFirstValue(tb), tableName, level)
		else
			xml2lua.parseTableToXml(tb, tableName, level)
		end

		if (xml2lua.pretty) then
			return table.concat(xml2lua.xmltb, '\n')
		end
		return table.concat(xml2lua.xmltb)
	end

	local function init()
		local obj = {
			root = {},
			options = {noreduce = {}}
		}

		obj._stack = {obj.root}  
		return obj  
	end

	--- @module XML Tree Handler.
	-- Generates a lua table from an XML content string.
	-- It is a simplified handler which attempts
	-- to generate a more 'natural' table based structure which
	-- supports many common XML formats.
	--
	-- The XML tree structure is mapped directly into a recursive
	-- table structure with node names as keys and child elements
	-- as either a table of values or directly as a string value
	-- for text. Where there is only a single child element this
	-- is inserted as a named key - if there are multiple
	-- elements these are inserted as a vector (in some cases it
	-- may be preferable to always insert elements as a vector
	-- which can be specified on a per element basis in the
	-- options).  Attributes are inserted as a child element with
	-- a key of '_attr'.
	--
	-- Only Tag/Text & CDATA elements are processed - all others
	-- are ignored.
	--
	-- This format has some limitations - primarily
	-- 
	-- * Mixed-Content behaves unpredictably - the relationship
	--   between text elements and embedded tags is lost and
	--   multiple levels of mixed content does not work
	-- * If a leaf element has both a text element and attributes
	--   then the text must be accessed through a vector (to
	--   provide a container for the attribute)
	--
	-- In general however this format is relatively useful.
	--
	-- It is much easier to understand by running some test
	-- data through 'testxml.lua -simpletree' than to read this)
	--
	-- Options
	-- =======
	--    options.noreduce = { <tag> = bool,.. }
	--        - Nodes not to reduce children vector even if only
	--          one child
	--
	--  License:
	--  ========
	--
	--  This code is freely distributable under the terms of the [MIT license](LICENSE).
	--
	--@author Paul Chakravarti (paulc@passtheaardvark.com)
	--@author Manoel Campos da Silva Filho
	local tree = init()

	---Instantiates a new handler object.
	--Each instance can handle a single XML.
	--By using such a constructor, you can parse
	--multiple XML files in the same application.
	--@return the handler instance
	function tree:new()
		local obj = init()

		obj.__index = self
		setmetatable(obj, self)

		return obj
	end

	--- Recursively removes redundant vectors for nodes
	-- with single child elements
	function tree:reduce(node, key, parent)
		for k,v in pairs(node) do
			if type(v) == 'table' then
				self:reduce(v,k,node)
			end
		end
		if #node == 1 and not self.options.noreduce[key] and 
			node._attr == nil then
			parent[key] = node[1]
		end
	end


	--- If an object is not an array,
	-- creates an empty array and insert that object as the 1st element.
	--
	-- It's a workaround for duplicated XML tags outside an inner tag. Check issue #55 for details.
	-- It checks if a given tag already exists on the parsing stack.
	-- In such a case, if that tag is represented as a single element,
	-- an array is created and that element is inserted on it.
	-- The existing tag is then replaced by the created array.
	-- For instance, if we have a tag x = {attr1=1, attr2=2}
	-- and another x tag is found, the previous entry will be changed to an array
	-- x = {{attr1=1, attr2=2}}. This way, the duplicated tag will be
	-- inserted into this array as x = {{attr1=1, attr2=2}, {attr1=3, attr2=4}}
	-- https://github.com/manoelcampos/xml2lua/issues/55
	--
	-- @param obj the object to try to convert to an array
	-- @return the same object if it's already an array or a new array with the object
	--         as the 1st element.
	local function convertObjectToArray(obj)
		--#obj == 0 verifies if the field is not an array
		if #obj == 0 then
			local array = {}
			table.insert(array, obj)
			return array
		end

		return obj
	end

	---Parses a start tag.
	-- @param tag a {name, attrs} table
	-- where name is the name of the tag and attrs
	-- is a table containing the atributtes of the tag
	function tree:starttag(tag)
		local node = {}
		if self.parseAttributes == true then
			node._attr=tag.attrs
		end

		--Table in the stack representing the tag being processed
		local current = self._stack[#self._stack]

		if current[tag.name] then
			local array = convertObjectToArray(current[tag.name])
			table.insert(array, node)
			current[tag.name] = array
		else
			current[tag.name] = {node}
		end

		table.insert(self._stack, node)
	end

	---Parses an end tag.
	-- @param tag a {name, attrs} table
	-- where name is the name of the tag and attrs
	-- is a table containing the atributtes of the tag
	function tree:endtag(tag, s)
		--Table in the stack representing the tag being processed
		--Table in the stack representing the containing tag of the current tag
		local prev = self._stack[#self._stack-1]
		if not prev[tag.name] then
			error("XML Error - Unmatched Tag ["..s..":"..tag.name.."]\n")
		end
		if prev == self.root then
			-- Once parsing complete, recursively reduce tree
			self:reduce(prev, nil, nil)
		end

		table.remove(self._stack)
	end

	---Parses a tag content.
	-- @param t text to process
	function tree:text(text)
		local current = self._stack[#self._stack]
		table.insert(current, text)
	end

	---Parses CDATA tag content.
	tree.cdata = tree.text
	tree.__index = tree

	xml2lua.tree = tree
	xml2lua.parserModule = XmlParser

	return xml2lua
end

local httpService = game:GetService("HttpService")
local compressionModule = compressionModule()
local vm = vmModule()
local root = xmlModule

local currentUpdateValue = plugin:GetSetting("AutoUpdate")
if currentUpdateValue == nil then
	currentUpdateValue = false
end
local checked = false

toggleAutoUpdates.Click:Connect(function()
	currentUpdateValue = not currentUpdateValue
	print("Auto-update status:",currentUpdateValue)
	if currentUpdateValue and not checked then
		local success,resp = pcall(function()
			update()
		end)
		if not success then
			warn("Failed to auto-update:",resp)
		end
	end
	plugin:SetSetting("AutoUpdate",currentUpdateValue)
end)


local assetId = 9376009942
add.Click:Connect(function()
	warn("Please note that installing this does not disable the default chat, plugins do not have the permissions required to do so.")
	
	local parent = game.Selection:Get()[1] or game:GetService("ServerScriptService")
	local loader = game:GetService("InsertService"):LoadAsset(assetId):GetChildren()[1]
	loader.Parent = parent
	loader.Config.Loader.Source = [[
	-- Author: @Jumpathy
-- Name: loader.lua
-- Description: Better chat loader

local configuration = require(script.Parent)
local addons = script.Parent.Parent:WaitForChild("Addons")
local toRequire = script:WaitForChild("src")

require(toRequire)(configuration,addons)
]]
	
	local s = Instance.new("ModuleScript")
	s.Parent = loader.Config.Loader
	s.Name = "src"
	s.Source = "return {}"
	
	game.Selection:Set({parent})
	update()
end)

local get = function(url,cb)
	local success,response = pcall(function()
		return httpService:GetAsync(url)
	end)
	if success and response then
		cb(response)
	else
		warn("[Failed to get]",response)
	end
end

local allowedTypes = {
	["ProtectedString"] = true,
	["string"] = true
}

local canWrite = {
	["Name"] = true,
	["Source"] = true
}

local interpret = function(array)
	local isAllTable = true
	for _,v in pairs(array) do
		if(typeof(v) ~= "table") then
			isAllTable = false
		end
	end
	if isAllTable then
		return array
	else
		return {{
			[1] = array[1],
			["_attr"] = array["_attr"]
		}}
	end
end

decodeItem = function(item)
	local object = {
		ClassName =  item["_attr"]["class"],
		Properties = {},
		Children = {}
	}
	
	local isTopbar = false
	for propertyType,propertyValues in pairs(item.Properties) do
		if allowedTypes[propertyType] then
			for _,property in pairs(interpret(propertyValues)) do
				if property["_attr"] then
					local propertyName = property["_attr"]["name"]
					if canWrite[propertyName] then
						if propertyName == "Name" and property[1] == "topbar" then
							isTopbar = true
						end
						object.Properties[propertyName] = property[1]
					end
				end
			end
		end
	end
	if item.Item then
		for _,item in pairs(item.Item) do
			if item["_attr"] then
				table.insert(object.Children,decodeItem(item))
			end
		end
	end
	if isTopbar then
		local old = object.Children
		object.Children = {{ -- weird fix, not sure why it happens
			Children = old,
			ClassName = "ModuleScript",
			Properties = {
				["Name"] = "icons",
				["Source"] = [[
				-- Credit: @ForeverHD (topbarPlus)
-- Name: icons.lua
-- Description: Topbar icons for the chat

local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local starterGui = game:GetService("StarterGui")

return function(environment)
	shared.newConfig = environment.config;
	local topbarPlusReference = replicatedStorage:FindFirstChild("TopbarPlusReference")
	local iconModule = script:WaitForChild("topbarPlus")
	if(topbarPlusReference) then
		iconModule = topbarPlusReference.Value
	end

	local icon = require(iconModule)
	local controller = require(iconModule:FindFirstChild("IconController") or iconModule.Parent:FindFirstChild("IconController"))
	local callback = environment.toggleSettingsMenu
	local settingIcon = icon.new():setImage(environment.config.SettingsMenu.TopbarButton.Icon)
	settingIcon.selected:Connect(callback)
	settingIcon.deselected:Connect(callback)
	if(environment.config.SettingsMenu.ApiEnabledAndUIDisabled == true) then
		settingIcon:setEnabled(false)
	end
	
	if(not environment.config.SettingsMenu.TopbarButton.Enabled) then
		settingIcon:setEnabled(false)
	end
	
	environment.settingIcon = settingIcon
	
	function environment:toggleSettingsTopbar()
		settingIcon:deselect()
	end
	
	function environment:openSettingsMenu()
		settingIcon:select()
	end
	
	local types = Enum.CoreGuiType:GetEnumItems()
	local cache = {}
	
	runService.Heartbeat:Connect(function()
		for _,class in pairs(types) do
			local current = starterGui:GetCoreGuiEnabled(class)
			if(cache[class] ~= current) then
				if(cache[class] ~= nil) then
					controller.updateTopbar()
				end
				cache[class] = current
			end
		end
	end)
end
]]
			}
		}}
	end
	return object
end

create = function(item,parent)
	local newObject = Instance.new(item.ClassName)
	newObject.Parent = parent

	for propertyName,propertyValue in pairs(item.Properties) do
		pcall(function()
			newObject[propertyName] = propertyValue
		end)
	end

	if #item.Children > 0 then
		for _,item in pairs(item.Children) do
			create(item,newObject)
		end
	end
	return newObject
end

local createFrom = function(xml,parent)
	local processed = decodeItem(xml.Item)
	return create(processed,parent)
end

local getLoader = function()
	local betterChatLoader;
	for _,obj in pairs(game:GetDescendants()) do
		local success,response = pcall(function()
			if obj:IsA("ModuleScript") and obj.Name == "Config" then
				if obj.Source:find("ChangeDisplayNameColorWhenAttributeChanged") then
					betterChatLoader = obj.Parent
					return true
				end
			end
			return false
		end)
		if success and response then
			break
		end
	end
	return betterChatLoader
end

update = function(override)
	if game:GetService("RunService"):IsRunning() then
		return
	end
	checked = true
	local loader = getLoader()
	if loader then
		local success,loaderScript = pcall(function()
			return loader.Config.Loader
		end)
		if success and loaderScript then
			local lines = loaderScript.Source:split("\n")
			local c = 0

			for idx,line in pairs(lines) do
				if(line:find("require")) then
					c += 1
					if(c == 1) then
						table.remove(lines,idx)
					end
				end
			end

			local location = Instance.new("ObjectValue")
			location.Value = loaderScript
			location.Parent = game.ServerStorage
			location.Name = "locationBetterChatSource"

			local toAdd = [[configuration = {}
local newSrc;
require = function(...)
	newSrc = ({...})[1]
	return function() end
end
local v = game.ServerStorage.locationBetterChatSource
local script = game.ServerStorage.locationBetterChatSource.Value
]]
			local s = toAdd .. table.concat(lines,"\n") .. "\nv.Value = newSrc"
			local success,response = pcall(vm(s))
			local isOriginal = false
			if loaderScript.Source:find("9375790695") then
				isOriginal = true
				location.Value = Instance.new("Part",loaderScript)
				location.Value.Name = "src"
				loaderScript.Source = [[
	-- Author: @Jumpathy
-- Name: loader.lua
-- Description: Better chat loader

local configuration = require(script.Parent)
local addons = script.Parent.Parent:WaitForChild("Addons")
local toRequire = script:WaitForChild("src")

require(toRequire)(configuration,addons)
]]
			end
			task.wait(0.25)
			
			if not success and not isOriginal then
				warn("Failed to find BetterChat source code location, is it referenced correctly in the loader script?")
				location:Destroy()
				return
			end
			local origin = location.Value
			local parent = origin.Parent
			local name = origin.Name
			location:Destroy()

			get("https://pastebin.com/raw/6wHsFsZT",function(raw)
				local body = httpService:JSONDecode(raw)
				if body.version ~= loader:GetAttribute("CurrentVersion") or override then
					if not override then
						warn("Version mismatch found, overwriting current code...")
					else
						warn("Overwriting source code...")
					end
					local start = tick()
					get(body.url,function(source)
						local base = compressionModule.decompress(source)
						local xmlParser = root()
						local handler = xmlParser.tree

						local parser = xmlParser.parser(handler)
						parser:parse(base)
						
						local decoded = handler.root

						local obj = createFrom(decoded.roblox,parent)
						obj.Name = name
						origin:Destroy()
						
						warn("Better Chat V3 successfully updated in " .. (tick() - start) .. "s")
						loader:SetAttribute("CurrentVersion",body.version)
					end)
				end
			end)
		else
			warn("Unable to identify loader script, it should be inside of Config")
		end
	else
		warn("Unable to locate BetterChat loader")
	end
end

if toggleAutoUpdates then
	task.spawn(function()
		update()
	end)
end

rewrite.Click:Connect(function()
	update(true)
end)