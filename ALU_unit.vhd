library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.NUMERIC_STD.all;
-----------------------------------------------
---------- ALU 4-bit VHDL ---------------------
-----------------------------------------------
entity ALU_unit is  
    Port (
    A, B     : in  STD_LOGIC_VECTOR(3 downto 0);  -- 2 inputs 4-bit
    ALU_Sel  : in  STD_LOGIC_VECTOR(2 downto 0);  -- 1 input 4-bit for selecting function
    ALU_Out   : out  STD_LOGIC_VECTOR(3 downto 0); -- 1 output 8-bit 
    Carryout : out std_logic        -- Carryout flag
    );
end ALU_unit; 
architecture Behavioral of ALU_unit is

signal ALU_Result : std_logic_vector (3 downto 0);
signal tmp: std_logic_vector (4 downto 0);
signal paridadA: std_logic;
signal paridadB: std_logic;

begin
   process(A,B,ALU_Sel, paridadA, paridadB)
 begin
  case(ALU_Sel) is
  when "000" => -- Subtraction
   ALU_Result <= A - B ;
	when "001" => -- Generador de bit de paridad
	paridadA <= ((A(3) xor A(2) ) xor A(1)) xor A(0);
	paridadB <= ((B(3) xor B(2) ) xor B(1)) xor B(0);
   ALU_Result <= "0000"+(paridadA xor paridadB) ; -- paridad de A concatenado con B
  when "010" => -- Logical xor 
   ALU_Result <= A xor B;
	when "011" => -- Logical or 
   ALU_Result <= A or B;
  when others => ALU_Result <= A + B ; 
  end case;
 end process;
 ALU_Out <= ALU_Result; -- ALU out
 tmp <= ('0' & A) + ('0' & B);
 Carryout <= tmp(4); -- Carryout flag
end Behavioral;