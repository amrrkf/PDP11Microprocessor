Library ieee;

Use ieee.std_logic_1164.all;

entity my_adder is

port (a,b,cin : in std_logic;
      s , cout : out std_logic );
end my_adder;


Architecture a_my_adder of my_adder is

begin 

process ( a ,b , cin)
begin 

s <= a xor b xor cin;
cout <= (a and b) or (cin and (a xor b));

end process;

end a_my_adder;