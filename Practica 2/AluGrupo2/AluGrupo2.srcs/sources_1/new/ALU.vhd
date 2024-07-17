
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use STD.textio.all;
use IEEE.std_logic_textio.all;

library UNISIM;
use UNISIM.VComponents.all;
entity alu is
    port( A, B : in  std_logic_vector(3 downto 0); -- Entradas de 4 bits
          xyz : in  std_logic_vector(2 downto 0); -- SeÃ±al de control de 3 bits
          O : out std_logic_vector(6 downto 0);
          cout: out std_logic :='0';
          enable : out std_logic_vector(3 downto 0)
         
        );
end alu;

architecture behavior of alu is
        signal  S : std_logic_vector(3 downto 0);
        signal  Dis : std_logic_vector(6 downto 0);
begin
    process(A, B, xyz)
        variable temp: std_logic_vector(3 downto 0);
        variable SS: std_logic_vector(4 downto 0);
        variable carry: std_logic;
    begin
        case xyz is
            when "000" =>
                temp := A; -- S = A
                carry := '0';
            when "001" =>
                carry := '0';
                temp := not A; -- S = not A
            when "010" =>
                 -- A + 2
                 SS:= "0" &  A + "0010";
                 temp := SS(3 downto 0);
                 carry:= SS(4);
                 
            when "011" =>
                temp := A; -- S = A
                carry := '0';
            when "100" =>
                temp := A nand B; -- S = A nand B
                carry := '0';
            when "101" =>
                temp := A nor B; -- S = A nor B
                carry := '0';
            when "110" =>
                SS:= "0" &  A + B;
                 temp := SS(3 downto 0);
                 carry:= SS(4);
            when "111" =>
                if A < B then
                    temp := "0000"; -- S = 0 si A < B
                    carry := '0';
                else
                    SS := "0" & A - B;
                    temp:= SS (3 downto 0);
                    carry := '0';
                end if;
           when others => temp:="0000";
        end case;
--        if unsigned(temp) > 15 then
--             cout <= '1';
--        else 
--            cout <= '0';
--        end if;
        S <= temp;
        
        cout <= carry;
    end process;
    process(S,Dis)
    begin
    case S is
    when "0000" => dis <="0000001";
    when "0001" => dis <="1001111";
    when "0010" => dis <="0010010";
    when "0011" => dis <="0000110";
    when "0100" => dis <="1001100";
    when "0101" => dis <="0100100";
    when "0110" => dis <="1100000";
    when "0111" => dis <="0001110";
    when "1000" => dis <="0000000";
    when "1001" => dis <="0000100";
    when "1010" => dis <="1111110";
    when "1011" => dis <="0110000";
    when "1100" => dis <="1101101";
    when "1101" => dis <="1111101";
    when "1110" => dis <="0110011";
    when "1111" => dis <="1011011";
    when others => dis<= "0000000";
    
    end case;
    O <= Dis;
    end process;
    enable <= "0000";
end behavior;
