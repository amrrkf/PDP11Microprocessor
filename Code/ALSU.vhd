Library ieee;

Use ieee.std_logic_1164.all;

entity ALSU  is  
		port (a,b:in std_logic_vector (15 downto 0);
		s : in std_logic_vector(3 downto 0);
		cin : in std_logic;
		F : out std_logic_vector (15 downto 0);
		cout: out std_logic;
		zero : out std_logic;
		negative : out std_logic;
		overflow : out std_logic
		);    
	end entity ALSU ;


-- take care of the usage of when else 
architecture  arch of ALSU is
  
	component partA  is  
		port (a,b:in std_logic_vector (15 downto 0);
		s : in std_logic_vector ( 1 downto 0);
		cin : in std_logic;
		F : out std_logic_vector (15 downto 0);
		cout: out std_logic;
		zero : out std_logic; -- zero Signal
		negative : out std_logic; -- negative signal    
		overflow : out std_logic); -- overflow flag
	end component;


component partB  is  		
	port (a,b :in std_logic_vector (15 downto 0);
		s : in std_logic_vector ( 1 downto 0);
		F : out std_logic_vector (15 downto 0);
		zero : out std_logic;
		negative : out std_logic;
		overflow : out std_logic
		);       
	end component ;
	
component partC  is  
		port (a:in std_logic_vector (15 downto 0);
		s : in std_logic_vector ( 1 downto 0 );
		cin : in std_logic;
		F : out std_logic_vector (15 downto 0);
		Cout : out std_logic;
		zero : out std_logic;
		negative : out std_logic;
		overflow : out std_logic);    
	end component ;
	
	component partD  is  
		port (a:in std_logic_vector (15 downto 0);
		s : in std_logic_vector ( 1 downto 0 );
		cin : in std_logic;
		F : out std_logic_vector (15 downto 0);
		Cout : out std_logic;
		zero : out std_logic;
		negative : out std_logic;
		overflow : out std_logic
		); 
	end component ;
	
	signal w0,w1,w2,w3 : std_logic_vector(15 downto 0);
	signal overflows : std_logic_vector(3 downto 0);
	signal negatives : std_logic_vector(3 downto 0);
	signal carries : std_logic_vector(2 downto 0);
	signal zeros : std_logic_vector(3 downto 0);
begin
  
	u0:partA port map(a,b,s(1 downto 0),cin,w0,carries(0),zeros(0),negatives(0),overflows(0));
    u1:partB port map(a,b,s(1 downto 0),w1,zeros(1),negatives(1),overflows(1));
    u2:partC port map(a,s(1 downto 0),cin,w2,carries(1),zeros(2),negatives(2),overflows(2));
    u3:partD port map(a,s(1 downto 0),cin,w3,carries(2),zeros(3),negatives(3),overflows(3));
      
      
F <= 	 w0 when s(2)='0' and  s(3)='0'
	else w1 when s(2)='1' and  s(3)='0'
	else w2 when s(2)='0' and  s(3)='1'
	else w3 when s(2)='1' and  s(3)='1';
 
cout <=  carries(0) when s(2)='0' and s(3)='0'
	else '0' 		when s(2)='1' and s(3)='0'
	else carries(1) when s(2)='0' and s(3)='1'
	else carries(2) when s(2)='1' and s(3)='1';
	
zero <= zeros(0)  when s(2)='0' and s(3)='0'
	else zeros(1) when s(2)='1' and s(3)='0'
	else zeros(2) when s(2)='0' and s(3)='1'
	else zeros(3) when s(2)='1' and s(3)='1';
	
negative <= negatives(0)  when s(2)='0' and s(3)='0'
	else negatives(1) when s(2)='1' and s(3)='0'
	else negatives(2) when s(2)='0' and s(3)='1'
	else negatives(3) when s(2)='1' and s(3)='1';

overflow <= overflows(0)  when s(2)='0' and s(3)='0'
	else overflows(1) when s(2)='1' and s(3)='0'
	else overflows(2) when s(2)='0' and s(3)='1'
	else overflows(3) when s(2)='1' and s(3)='1';
		
    
end arch;

