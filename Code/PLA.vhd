library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


Entity PLA is
port (
Pla_Out : in std_logic;
IR : in std_logic_vector(15 downto 0);
Z_flag : in std_logic;
uAR : out std_logic_vector(7 downto 0));
end entity PLA;

architecture AR_generate of PLA is

signal Add_Mode : std_logic_vector (7 downto 0);
begin

Add_Mode(7 downto 6)<="00";
Add_Mode(2 downto 0)<="000";
Add_Mode(5)<=IR(9);
Add_Mode(4)<=IR(8);
Add_Mode(3)<=IR(7) and (not IR(9)) and (not IR(8));


uAR<="01000001" or Add_Mode when IR(15 downto 14)="00" and Pla_Out = '1'     --two operand instructions, assign it to 101 then oring with src add. mode
else "10000000" when IR(15 downto 14)="10" and Pla_Out = '1'		--one operand instructions
else "00000100" when IR="1100000000000000" and Pla_Out = '1' 		--HLT (Halt)
else "00000000" when IR="1100000000000001" and Pla_Out = '1'		--NOP (No operation)
else "00100011" when IR(15 downto 8)="11000001"  and Pla_Out = '1'	--BR (Branch unconditionally) 
else "00100011" when IR(15 downto 8)="11000010" and Pla_Out = '1' and Z_flag='0'	--BNE (Branch if <>0)
else "00100011" when IR(15 downto 8)="11000011" and Pla_Out = '1' and Z_flag='1'	--BEQ (Branch if =0)
else "10000000" when IR(15 downto 7)="110010000" and Pla_Out = '1'	--JSR (jump to subroutine)
else "00111000" when IR(15 downto 7)="110100000"  and Pla_Out= '1'	--RTS (return from subroutine)
else "00000000";

end architecture AR_generate;
