Library ieee;
use ieee.std_logic_1164.all;
Entity DECODING_CIRCUIT is
port(  
ORresult : in std_logic;
ORinddst: in std_logic;
ORindsrc: in std_logic;
ORdst: in std_logic;
OR2op: in std_logic;
ORop : in std_logic;
OR1op : in std_logic;
Pla_Out: in std_logic;
NEXT_ADDRESS:in std_logic_vector(7 downto 0);
IRin: in std_logic_vector(15 downto 0);
Z_flag : in std_logic;
NEW_uAR:out std_logic_vector(7 downto 0) );
		
end entity DECODING_CIRCUIT;

Architecture d_circuit of DECODING_CIRCUIT is
component PLA is
	port (
Pla_Out : in std_logic;
IR : in std_logic_vector(15 downto 0);
Z_flag : in std_logic;
uAR : out std_logic_vector(7 downto 0));
	end component;

component BITORING is
	 port( IR : in std_logic_vector( 15 downto 0);
	NEXT_ADDRESS : in std_logic_vector( 7 downto 0);
	ORdst,ORresult,ORindsrc,ORinddst,OR2op,ORop,OR1op : in std_logic;
	uAR : out std_logic_vector(7 downto 0));
	end component;
	
	signal pla_add:std_logic_vector(7 downto 0);
	signal oring_add:std_logic_vector(7 downto 0);
	
begin
pla0:PLA port map(Pla_Out,IRin,Z_flag,pla_add);
bit_oring0: BITORING port map(IRin,NEXT_ADDRESS,ORdst,ORresult,ORindsrc,ORinddst,OR2op,ORop,OR1op,oring_add);
NEW_uAR<= oring_add or pla_add;

end d_circuit;