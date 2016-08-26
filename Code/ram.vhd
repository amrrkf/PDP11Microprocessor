library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

Entity ram is
port (
clk : in std_logic;
R,W : in std_logic;
address : in std_logic_vector(15 downto 0);
datain : in std_logic_vector(15 downto 0);
dataout : out std_logic_vector(15 downto 0) ;
MFC : out std_logic);
end entity ram;

architecture syncrama of ram is
	component my_DFF  is  
		port( d,clk,rst,EN : in std_logic;
		q : out std_logic);
	end component ;

   type ram_type is array(0 to 2048) of std_logic_vector(15 downto 0);

	signal ram : ram_type := (
0   =>  "0000000011100000",	-- Mov @(R3),R0
1   =>  "0000000011000001",	-- Mov @(R2),R1
2   =>  "0000010000000001",	-- Add R0,R1
3   =>  "0011000000000001",	-- Bit test R0,R1 
4	=>	"0000000000100010",	-- Mov R1,R2
5	=>	"0000100000000010",	-- Sub R0,R2
6	=>	"1100000000000001",	-- NOP
7	=>	"0001010001000001",	-- OR R2,R1
8	=>	"0001100000100010",	-- XOR R1,R2
9	=>	"0000010010111011",	-- Add @R1,X(R3)
10	=>	"0000010010111011",	-- X
11	=>	"0001110001000011",	-- cmp R2,R3
12	=>	"0001000011000001",	-- Bic @R2,R1
13  =>	"1000000011100001", -- Inv R1
14  =>	"1000000100000001", -- LSR R1
15  =>	"1000010000011100",	-- jmp @X(R0)
16  =>	"0000000000010000",
209 =>	"0000000011010010",
210 =>	"0000000011010011",
211 =>	"1000001001110010",	-- Clr(-R2)
212 =>	"1000000101110110",	-- ASR @-(R2)
213 =>	"1000000101000100",	-- RORC @(R0)
214 =>	"1100000101110011",	-- BR
255 =>  "0000000000000001",
330 =>	"1000000000000010",	-- Inc R2
331 =>	"1000000001100001",	-- Dec R1
332 =>	"0000010001100010",	-- Add R3,R2
333 =>	"1000000100101010",	-- ROR(R2)+
334 =>	"1000000110000010",	-- LSL(R2)
335 =>	"1100001001100011",	-- BNE
435 =>	"0000001111100001",	-- Mov @X(R3),R1
436 =>	"0000001011110000",
437 =>	"1100100000000001",	-- JSR R0,R1
438 =>	"1100000000000000",	-- HLT
1189 => "0000010010100110",
1190 => "0000010010100111",
1191 => "1000000111000001", -- ROLC(R1)
1192 =>	"1100001100001111",	-- BEQ
1193 =>	"1101000000000001",	-- RTS R2,R1
others => "1100000000000001"
);

	signal mem_R,mem_w :std_logic;
	begin
		process(clk) is
		  Begin
			if falling_edge(clk) then  
			  if (mem_W = '0' and mem_R = '1') then
				dataout <= ram(to_integer(unsigned(address)));
			  elsif(mem_W = '1' and mem_R = '0') then
				ram(to_integer(unsigned(address))) <= datain;
			  end if;
			  
			  if (mem_W = '0' and mem_R = '1') then
				MFC <= '1';
			  else
				MFC <= '0';
			  end if;
			end if;
		end process;
		read_reg:my_DFF port map(R,clk,'0','1',mem_R);
		write_reg:my_DFF port map(W,clk,'0','1',mem_W);

end architecture syncrama;
