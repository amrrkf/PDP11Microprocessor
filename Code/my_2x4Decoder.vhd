Library ieee;
use ieee.std_logic_1164.all;
Entity my_2x4Decoder is
port(A : in std_logic_vector(1 downto 0);
	E : in std_logic;
	D : out std_logic_vector(3 downto 0));
end my_2x4Decoder;

Architecture a_my_2x4Decoder of my_2x4Decoder is
begin

D <= "0001" WHEN A = "00" and E = '1'
	else "0010" WHEN A = "01" and E = '1'
	else "0100" WHEN A = "10" and E = '1'
	else "1000" WHEN A = "11" and E = '1'
	else "0000";
end a_my_2x4Decoder;
