library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.textio.all;
use IEEE.std_logic_textio.all;
library UNISIM;
use UNISIM.VComponents.all;


entity Parte2TB is
generic(M: integer:=3;
            N: integer:=4
            );
end Parte2TB;

architecture Behavioral of Parte2TB is
component parte2 is
generic(M: integer:=3;
            N: integer:=4
            );
    port(
    FA: in std_logic;
    FB: in std_logic;
    EN0: in std_logic ;
    EN1: in std_logic ;
    EN2: in std_logic;
    sel_alu: in std_logic_vector (2 downto 0);
    add_A: in std_logic_vector (M-1 downto 0);
    add_b: in std_logic_vector (M-1 downto 0);
    dataA: in std_logic_vector (N-1 downto 0);
    dataB: in std_logic_vector (N-1 downto 0);
    clk: in std_logic ;
    rst: in std_logic ;
    O: out std_logic_vector (6 downto 0) 
    
    );
end component;
    signal all_inputs : std_logic_vector(18 downto 0);
    signal FA_tb: std_logic;
    signal FB_tb: std_logic;
    signal EN0_tb: std_logic ;
    signal EN1_tb: std_logic ;
    signal EN2_tb: std_logic ;
    signal sel_alu_tb: std_logic_vector (2 downto 0);
    signal add_A_tb: std_logic_vector (M-1 downto 0);
    signal add_b_tb: std_logic_vector (M-1 downto 0);
    signal dataA_tb: std_logic_vector (N-1 downto 0);
    signal dataB_tb: std_logic_vector (N-1 downto 0);
    signal clk_tb: std_logic ;
    signal rst_tb: std_logic ;
    signal O_tb: std_logic_vector (6 downto 0);
    
    
    procedure P2_Exp(
    FA_e: in std_logic:='0';
    FB_e:in std_logic:='0';
    sel_alu_e: in std_logic_vector (2 downto 0):=(others => '0');
    add_A_e: in std_logic_vector (M-1 downto 0):=(others => '0');
    add_b_e: in std_logic_vector (M-1 downto 0):=(others => '0');
    dataA_e: in std_logic_vector (N-1 downto 0):=(others => '0');
    dataB_e: in std_logic_vector (N-1 downto 0):=(others => '0');
    O_e: out std_logic_vector (6 downto 0)
    )is
    variable ALU_A: std_logic_vector(3 downto 0);
    variable ALU_B: std_logic_vector(3 downto 0);
    variable Saux: std_logic_vector(3 downto 0);
    variable carry: std_logic;
    variable SS: std_logic_vector(4 downto 0);
    variable dis: std_logic_vector(6 downto 0);
    type rom_type is array (0 to 7) of std_logic_vector(3 downto 0);
    constant ROM_A_e : rom_type := (X"A", X"C", X"D", X"2", X"4", X"6", X"7", X"3");
    constant ROM_B_e : rom_type := (X"2", X"3", X"5", X"A", X"D", X"5", X"4", X"3");
    
    begin
    if(FA_e= '0' and FB_e = '0') then
            ALU_A := ROM_A_e(conv_integer(add_A_e));
            ALU_B := dataB_e;
    elsif(FA_e= '0' and FB_e = '0') then
            ALU_A := dataA_e;
            ALU_B := dataB_e;
    elsif(FA_e= '0' and FB_e = '0') then
            ALU_A := ROM_A_e(conv_integer(add_A_e));
            ALU_B := ROM_B_e(conv_integer(add_B_e));
    else
            ALU_A := dataA_e;
            ALU_B := ROM_B_e(conv_integer(add_B_e));
    end if;
    
    case sel_alu_e is
            when "000" =>
                saux:= alu_a; -- S = A
                carry := '0';
            when "001" =>
                carry := '0';
                saux := not alu_a; -- S = not A
            when "010" =>
                 -- A + 2
                 SS:= "0" &  alu_a + "0010";
                 saux := SS(3 downto 0);
                 carry:= SS(4);
                 
            when "011" =>
                saux := alu_a; -- S = A
                carry := '0';
            when "100" =>
                saux := alu_a nand alu_b; -- S = A nand B
                carry := '0';
            when "101" =>
                saux := alu_a nor alu_b; -- S = A nor B
                carry := '0';
            when "110" =>
                SS:= "0" &  alu_a + alu_b;
                 saux := SS(3 downto 0);
                 carry:= SS(4);
            when "111" =>
                if alu_a < alu_b then
                    saux := "0000"; -- S = 0 si A < B
                    carry := '0';
                else
                    SS := "0" & Alu_a - alu_b;
                    carry := '0';
                end if;
           when others => saux:="0000";
        end case;
        case Saux is
    when "0000" => dis :="0000001";
    when "0001" => dis :="1001111";
    when "0010" => dis :="0010010";
    when "0011" => dis :="0000110";
    when "0100" => dis :="1001100";
    when "0101" => dis :="0100100";
    when "0110" => dis :="1100000";
    when "0111" => dis :="0001110";
    when "1000" => dis :="0000000";
    when "1001" => dis :="0000100";
    when "1010" => dis :="1111110";
    when "1011" => dis :="0110000";
    when "1100" => dis :="1101101";
    when "1101" => dis :="1111001";
    when "1110" => dis :="0110011";
    when "1111" => dis :="1011011";
    when others => dis := "0000000";
    end case;
    O_e := dis;    
    end p2_Exp;
    
begin
dut : parte2
    port map(
        FA=>FA_tb,
        FB=>FB_tb,
        EN0=>EN0_tb,
        EN1=>EN1_tb,
        EN2=>EN2_tb,
        sel_alu=>sel_alu_tb,
        add_A=>add_A_tb,
        add_b=>add_b_tb,
        dataA=>dataA_tb,
        dataB=>dataB_tb,
        clk=>clk_tb,
        rst=>rst_tb, 
        O=>O_tb
    );
    process
    variable O_exp : std_logic_vector(6 downto 0);
    variable s : line;
    begin
    for i in 0 to 525000 loop
        CLK_tb <= '0';
        EN0_tb <= '1';
        EN1_tb <= '1';
        EN2_tb <= '0';
        wait for 10ns;
        CLK_tb <= '1';
        wait for 10ns;
        CLK_tb <= '0';
        en0_tb <= '0';
        en1_tb <= '0';
        en2_tb <= '1';
        wait for 10ns;
        CLK_tb <= '1';
        All_inputs <= all_inputs+1;
        FA_tb <= All_inputs(14);
        FB_tb <= All_inputs(15);
        dataA_tb <= All_inputs(3 downto 0);
        dataB_tb <= All_inputs(7 downto 4);
        add_a_tb <= All_inputs(10 downto 8);
        add_b_tb <= All_inputs(13 downto 11);
        sel_alu_tb <= All_inputs(18 downto 16);
        
        p2_EXP(FA_tb,FB_tb,sel_alu_tb,add_A_tb,Add_B_tb,dataA_tb,dataB_tb,O_Exp);
        if(i/=0) then
            if(O_exp = O_tb) then
                write(s, string'("ES CORRECTO"));
                write(s, string'("ESPERADO DISPLAY: ")); write(s, O_exp);
                write(s, string'("DISPLAY: ")); write(s,O_tb);
                writeline (output, s);
            else
                write(s, string'("NO ES EL ESPERADO "));
                write(s, string'("ESPERADO DISPLAY: ")); write(s, O_exp);
                write(s, string'("DISPLAY: ")); write(s,O_tb);
                writeline (output, s);
            end if;
        end if;
        all_inputs <= all_inputs + 1;
    end loop;
    end process;
end Behavioral;
