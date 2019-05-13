library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is -- Interfaz entre la ALU y los 7 segmentos
	port(
		clk: in std_logic;
		sw : in std_logic_vector(3 downto 0);  -- 3 botones de selector de operacion
		sseg : out std_logic_vector(7 downto 0); -- salida comun de los 7 segmentos
		an : out std_logic_vector(3 downto 0) ;  -- anodos de los 7 segmentos
		carryout :out std_logic
	);
	
	end ALU;
	
architecture arch of ALU is
	signal a_data, b_data, r_data: std_logic_vector (3 downto 0) ;
begin
	a_data <= "0100"; -- 4
	b_data <= "0010"; -- 2
	alu_unit0:entity work.ALU_unit
		port map(
		A => a_data, 
		B => b_data, 
		ALU_Sel => sw(2 downto 0) ,   -- selector asigando a los switches (solo 3 botones)
		ALU_out => r_data,
		Carryout => carryout
		);

	-- driverDisplay para visualizar los datos de la alu
	driver_display_unit0: entity work.driver_display
		port map(
			clk =>clk,
			a => a_data, -- 4
			b => b_data, -- 2
			r => r_data,
			d => sw,  -- operacion actual
			sseg => sseg ,
			an => an
		);
		
		
		
end arch;