Library ieee;
use ieee.std_logic_1164.all;
Entity my_3x8Decoder is
port(A : in std_logic_vector(2 downto 0);
	E : in std_logic;
	D : out std_logic_vector(7 downto 0));
end my_3x8Decoder;

Architecture a_my_3x8Decoder of my_3x8Decoder is
begin

D <= "00000001" WHEN A = "000" and E = '1'
	else "00000010" WHEN A = "001" and E = '1'
	else "00000100" WHEN A = "010" and E = '1'
	else "00001000" WHEN A = "011" and E = '1'
	else "00010000" WHEN A = "100" and E = '1'
	else "00100000" WHEN A = "101" and E = '1'
	else "01000000" WHEN A = "110" and E = '1'
	else "10000000" WHEN A = "111" and E = '1'
	else "00000000";
end a_my_3x8Decoder;
