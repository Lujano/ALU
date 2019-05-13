library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is -- Multiplexacion por tiempo de 7 segmentos
	port(
		clk: in  std_logic;  -- fuente de reloj de la FPGA
		sw: in std_logic_vector(7 downto 0); -- Primer valor a mostrar
		sseg : out std_logic_vector(7 downto 0); -- salida comun de los 7 segmentos
		an : out std_logic_vector(3 downto 0)   -- anodos de los 7 segmentos
	);
	
	end ALU;
	
	
architecture arch of ALU is
begin
	
	sseg <= "10000011";
end arch;

	

	
	
	
	
	
	
	
	