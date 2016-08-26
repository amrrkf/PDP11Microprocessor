Library ieee;

Use ieee.std_logic_1164.all;

entity partA  is  
		port (a,b:in std_logic_vector (15 downto 0);
		s : in std_logic_vector( 1 downto 0);
		cin : in std_logic;
		F : out std_logic_vector (15 downto 0);
		cout: out std_logic;
		zero : out std_logic; -- zero Signal
		negative : out std_logic; -- negative signal    
		overflow : out std_logic); -- overflow flag
	end entity partA ;


-- take care of the usage of when else 
architecture  arch4 of partA is

component my_nadder is
       generic (n : integer := 16);
port   (a, b : in std_logic_vector(n-1  downto 0) ;
             cin : in std_logic;  
             s : out std_logic_vector(n-1 downto 0);
             cout : out std_logic);
end component;

signal bb,out1 :std_logic_vector(15 downto 0);
signal	cout1 :std_logic;
signal f_out : std_logic_vector(15 downto 0);		
signal f_last : std_logic;		
begin

bb <= "0000000000000000" when s(0)='0' and  s(1)='0'
	else b when s(0)='1' and  s(1)='0'
	else not b when s(0)='0' and  s(1)='1'
	else "1111111111111111" when s(0)='1' and  s(1)='1';

u0:my_nadder port map(a,bb,cin,out1,cout1);

f_out <= "0000000000000000" when s(0)='1' and  s(1)='1' and cin='1'
	else out1;

f_last  <= '0' when s(0)='1' and s(1) ='1' and cin='1'
else out1(15);

F <= f_out;

-- overflow flag, check last bit of the 2 operands and the result
overflow <= '1' when ( a(15) = '1' and bb(15) = '1' and f_last = '0' ) or ( a(15) = '0' and bb(15) = '0' and f_last ='1' ) 
else '0';

-- zero bit
zero <= '1' when f_out = "0000000000000000"
      else '0'; 
	
-- negative bit
negative <= f_out(15);

cout <= '0' when s(0)='1' and  s(1)='1' and cin='1'
	else cout1;
 
     -- TODO : write the architecture of mux2 
end arch4;


