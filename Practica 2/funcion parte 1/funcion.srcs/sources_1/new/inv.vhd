
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Inv is
port(
a: in std_logic;
b: out std_logic 
);
end Inv;
architecture Behavioral of Inv is
begin
b <= not(a);
end Behavioral;


