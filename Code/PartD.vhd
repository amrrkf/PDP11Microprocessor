Library ieee;

Use ieee.std_logic_1164.all;

entity partD  is  
		port (a:in std_logic_vector (15 downto 0);
		s : in std_logic_vector ( 1 downto 0);
		cin : in std_logic;
		F : out std_logic_vector (15 downto 0);
		Cout : out std_logic;
		zero : out std_logic;
		negative : out std_logic;
		overflow : out std_logic
		);    
end entity partD ;


-- take care of the usage of when else 
architecture  arch3 of partD is

signal fout : std_logic_vector(15 downto 0);
begin
fout <= a(14 downto 0) & '0' when s(0)='0' and  s(1)='0'
else a(14 downto 0) & a(15) when s(0)='1' and  s(1)='0'
 else a(14 downto 0) & cin when s(0)='0' and  s(1)='1'
 else a(15) & a(13 downto 0) & '0' when s(0)='1' and  s(1)='1';
 
 F <= fout;
 
 zero <= '1' when fout = "0000000000000000"
 else '0';
 
 negative <= fout(15);
 
 overflow <= '1' when (s(0)='1' and s(1)='1' and ( (a(15) xor a(14))='1' ))
			else '0';
 
 Cout <= a(15) when (s(0) ='0' and s(1)='0') or ( s(0) ='0' and s(1)='1') or ( s(0)='1' and s(1)='1')
 else '0';

 end arch3;

