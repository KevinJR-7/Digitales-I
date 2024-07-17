
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use STD.textio.all;
use IEEE.std_logic_textio.all;

library UNISIM;
use UNISIM.VComponents.all;

Entity funcion_tb Is
end funcion_tb;

Architecture behavior of funcion_tb Is
	Component funcion
	port (
		abc : in std_logic_vector(2 downto 0);
		xyz : out STD_LOGIC_vector(2 downto 0)
		
	);	
	End Component;
	
    Signal abc : STD_LOGIC_VECTOR(2 downto 0) :="000";
	Signal xyz : STD_LOGIC_VECTOR(2 downto 0) ;
	Signal count_int_2: std_logic_vector(2 downto 0) :="000";

	procedure expected_led (
		abc_in : in std_logic_vector(2 downto 0);
		xyz : out STD_LOGIC_vector(2 downto 0) 
	) is
	
	Variable led_expected_int : std_logic;
		   
	begin		
	--S1    
		led_expected_int := (not(abc(1)) or not(abc(0))) and (abc(2) or abc(0)); 
        xyz(0) := led_expected_int;
        xyz(1):=led_expected_int;
        xyz(2) := led_expected_int;
	end expected_led;
	
begin
	uut:  funcion PORT MAP (
	    abc => abc,
		xyz => xyz
		 );
		 
	process
		variable s : line;
		variable i : integer := 0;
		variable count : integer := 0;
	    variable proc_out : STD_LOGIC_VECTOR(2 downto 0);
        Variable abc1: std_logic_vector(2 downto 0)
        ;

	begin
        for i in 0 to 7 loop  
	      count := count + 1;
	               	  
		  wait for 50 ns;
		  abc <= count_int_2;
		  wait for 10 ns;
		  expected_led (abc,proc_out);
--		  write(s, proc_out);
--		  WRITELINE(output, s);
		  ---led_exp_out <= proc_out;

--		   If the outputs match, then announce it to the simulator console.
          if (xyz(2) = proc_out(2)) then
                write (s, string'("La salida LED concuerda en:")); write (s, count );write (s, string'(". El valor Entrada ")); write (s, abc); write (s, string'(". El valor esperado es: ")); write (s, xyz(2)); write (s, string'(" Lo que nos da el circuito es: ")); write (s, proc_out(2)); 
                writeline (output, s);
          else
              writeline (output, s);
          end if;
          
          if (xyz(1) = proc_out(1)) then
                write (s, string'("La salida LED concuerda en:")); write (s, count );write (s, string'(". El valor Entrada ")); write (s, abc); write (s, string'(". El valor esperado es: ")); write (s, xyz(1)); write (s, string'(" Lo que nos da el circuito es: ")); write (s, proc_out(1)); 
                writeline (output, s);
          else
              write (s, string'("La salida no concuerda en:")); write (s, count);write (s, string'(". El valor Entrada ")); write (s, abc); write (s, string'(". Expected: ")); write (s, xyz(1)); write (s, string'(" Actual: ")); write (s, proc_out(1)); 
              writeline (output, s);
          end if;
          
          if (xyz(0) = proc_out(0)) then
                write (s, string'("La salida LED concuerda en:")); write (s, count );write (s, string'(". El valor Entrada ")); write (s, abc);write (s, string'(". El valor esperado es: ")); write (s, xyz(0)); write (s, string'(" Lo que nos da el circuito es: ")); write (s, proc_out(0)); 
                writeline (output, s);
                
          else 
              write (s, string'("La salida no concuerda en:")); write (s, count);write (s, string'(". El valor Entrada ")); write (s, abc); write (s, string'(". Expected: ")); write (s, xyz(0)); write (s, string'(" Actual: ")); write (s, proc_out(0)); 
              writeline (output, s);
          end if;
		  		  
--		  -- Increment the switch value counters.
		  count_int_2 <= count_int_2 + 1;
        end loop;		 
       
	end process;
end behavior;
