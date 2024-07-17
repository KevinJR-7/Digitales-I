


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.textio.all;
use IEEE.std_logic_textio.all;

library UNISIM;
use UNISIM.VComponents.all;
entity alu_tb is   
end alu_tb;

architecture behavior of alu_tb is
        component alu
        port(
            A, B : in  std_logic_vector(3 downto 0); -- Entradas de 4 bits
              xyz : in  std_logic_vector(2 downto 0); -- Señal de control de 3 bits
              O : out std_logic_vector(6 downto 0);
              cout: out std_logic;
            enable: out std_logic_vector(3 downto 0);
            S1 : out std_logic_vector(3 downto 0) 
        );
        End Component;
        
           signal  A_s, B_s :   std_logic_vector(3 downto 0):="0000";-- Entradas de 4 bits
           signal xyz_s : std_logic_vector(2 downto 0); -- Señal de control de 3 bits
           signal O_s : std_logic_vector(6 downto 0);
           signal cout_s: std_logic;
           signal enable_s : std_logic_vector(3 downto 0);
           signal So_s : std_logic_vector(3 downto 0);
        Procedure ALUT(
            A_t, B_t : in std_logic_vector(3 downto 0);
            xyz_t : in  std_logic_vector(2 downto 0);
            So_t : out std_logic_vector(3 downto 0);
            O_t : out std_logic_vector(6 downto 0);
            cout_t: out std_logic 
            --cout_t: out std_logic
        ) is
        variable temp: std_logic_vector(3 downto 0);
        variable S_aux: std_logic_vector(3 downto 0);
        variable SS: std_logic_vector(4 downto 0);
        variable carry: std_logic:='0';
        begin
        case xyz_t is
            when "000" =>
                temp := A_t; -- S = A
            when "001" =>
            
                temp := not A_t; -- S = not A
            when "010" =>
                 -- A + 2
                 SS:= "0" &  A_t + "0010";
                 temp := SS(3 downto 0);
                 carry:= SS(4);
            when "011" =>
                temp := A_t; -- S = A
                carry := '0';
            when "100" =>
                temp := A_t nand B_t; -- S = A nand B
                carry := '0';
            when "101" =>
                temp := A_t nor B_t ; -- S = A nor B
                carry := '0';
            when "110" =>
                SS:= "0" &  A_t + B_t;
                temp := SS(3 downto 0);
                carry:= SS(4);
            when "111" =>
                if A_t < B_t then
                    temp := "0000"; -- S = 0 si A < B
                    carry := '0';
                else
                    SS := "0" & A_t - B_t;
                    temp:= SS (3 downto 0);
                    carry := '0';
                end if;
           when others => temp:="0000";
           end case;
           S_aux:=temp;
           So_t:=temp;
           cout_t :=  carry;

         case S_aux is
    when "0000" => O_t :="0000001";
    when "0001" => O_t :="1001111";
    when "0010" => O_t :="0010010";
    when "0011" => O_t :="0000110";
    when "0100" => O_t :="1001100";
    when "0101" => O_t :="0100100";
    when "0110" => O_t :="1100000";
    when "0111" => O_t :="0001110";
    when "1000" => O_t :="0000000";
    when "1001" => O_t :="0000100";
    when "1010" => O_t :="1111110";
    when "1011" => O_t :="0110000";
    when "1100" => O_t :="1101101";
    when "1101" => O_t :="1111101";
    when "1110" => O_t :="0110011";
    when "1111" => O_t :="1011011";
    when others => O_t :="0000000";
    end case;
    end ALUT;
    
begin
dut : alu
    port map (
      A => A_s,
      B => B_s,
      xyz => xyz_s,
      O => O_s,
      cout=> cout_s,
      enable => enable_s,
      S1=>So_s
      
    );
    process
        variable s : line;
        variable proc_out : std_logic_vector(6 downto 0);
        variable i : integer:=0;
        variable So_ax : std_logic_vector(3 downto 0);
        variable proc_carry : std_logic:='0';
    begin
    wait for 20ns;
    
    for i in 0 to 15 loop
        A_s <= std_logic_vector(TO_UNSIGNED(i, 4));
      
      for j in 0 to 15 loop
        B_s <= std_logic_vector(TO_UNSIGNED(j, 4));
        
        for k in 0 to 7 loop
            xyz_s <= std_logic_vector(TO_UNSIGNED(k, 3));

           wait for 10ns;   
           
           ALUT (A_s, B_s, xyz_s,So_ax, proc_out,proc_carry);
           wait for 10ns;
   
           
           if(O_s = proc_out) then
            write(s, string'("A = ")); write(s, A_s);
            write(s, string'(", B = ")); write(s, B_s);
            write(s, string'(", XYZ = ")); write(s, xyz_s);
            write(s, string'(", carry_alu = ")); write(s,cout_s);
            write(s, string'(", carry_teST = ")); write(s, proc_carry);
            write(s, string'(", pantalla_alu = ")); write(s, O_s);
            write(s, string'(", pantalla_test = ")); write(s, proc_out);
            write(s, string'(". CORRECTO!"));
            writeline(output, s);
            
           else
           
            write(s, string'("A = ")); write(s, A_s);
            write(s, string'(", B = ")); write(s, B_s);
            write(s, string'(", XYZ = ")); write(s, xyz_s);
            write(s, string'(", S_alu = ")); write(s, So_s);
            write(s, string'(", S_teST = ")); write(s, So_ax);
            write(s, string'(", pantalla_alu = ")); write(s, O_s);
            write(s, string'(", pantalla_test = ")); write(s, proc_out);
            write(s, string'(". INCORRECTO!"));
            writeline(output, s);
           end if;
        end loop;
      end loop;
    end loop;
    end process;
end behavior;

 
