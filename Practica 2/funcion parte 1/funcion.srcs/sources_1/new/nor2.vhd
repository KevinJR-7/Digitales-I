library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity nor2 is
    port(
        a: in std_logic;
        b: in std_logic;
        c: out std_logic
        );
end nor2;
architecture Behavioral of nor2 is
begin
    c <= a nor b;
end Behavioral;





