Library ieee;
use ieee.std_logic_1164.all;
Entity my_4x16Decoder is
port(A : in std_logic_vector(3 downto 0);
	E : in std_logic;
	D : out std_logic_vector(15 downto 0));
end my_4x16Decoder;

Architecture a_my_4x16Decoder of my_4x16Decoder is
begin

D <= "0000000000000001" WHEN A = "0000" and E = '1'
	else "0000000000000010" WHEN A = "0001" and E = '1'
	else "0000000000000100" WHEN A = "0010" and E = '1'
	else "0000000000001000" WHEN A = "0011" and E = '1'
	else "0000000000010000" WHEN A = "0100" and E = '1'
	else "0000000000100000" WHEN A = "0101" and E = '1'
	else "0000000001000000" WHEN A = "0110" and E = '1'
	else "0000000010000000" WHEN A = "0111" and E = '1'
	else "0000000100000000" WHEN A = "1000" and E = '1'
	else "0000001000000000" WHEN A = "1001" and E = '1'
	else "0000010000000000" WHEN A = "1010" and E = '1'
	else "0000100000000000" WHEN A = "1011" and E = '1'
	else "0001000000000000" WHEN A = "1100" and E = '1'
	else "0010000000000000" WHEN A = "1101" and E = '1'
	else "0100000000000000" WHEN A = "1110" and E = '1'
	else "1000000000000000" WHEN A = "1111" and E = '1'
	else "0000000000000000";
end a_my_4x16Decoder;
