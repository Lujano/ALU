library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity driver_display is -- Interfaz entre la ALU y los 7 segmentos
	port(
		clk: in std_logic;
		a: in std_logic_vector(3 downto 0);  -- Valor A de la alu
		b: in std_logic_vector(3 downto 0); --  Valor b de la alu
		r: in std_logic_vector(3 downto 0);
		d: in std_logic_vector(3 downto 0);	
		sseg : out std_logic_vector(7 downto 0); -- salida comun de los 7 segmentos
		an : out std_logic_vector(3 downto 0)   -- anodos de los 7 segmentos
	);
	
	end driver_display;
	
architecture arch of driver_display is
	signal inc: std_logic_vector (7 downto 0) ;
	signal led3, led2, led1, led0: std_logic_vector (7 downto 0) ;
	signal an_negado: std_logic_vector(3 downto 0);
begin
	-- instanciar cuatro instancias de hex-decoders
	-- instanciar para cuatro LSBs de las entradas
	
	-- el formato del decoder es punto abcdefg
	sseg_unit_0: entity work.hex_to_sseg
		port map(
			hex => a ,
			dp  => '0',
			sseg => led0 -- Primer led izquierda a derecha
		);
	
	-- instanciar 4 MSBs de la entrada
	sseg_unit_1: entity work.hex_to_sseg
		port map(
			hex => b ,
			dp  => '0',
			sseg => led1
		);
	
	
	-- instanciar 4 LSBs de la entrada incrementada
	sseg_unit_3: entity work.hex_to_sseg
		port map(
			hex => r ,
			dp  => '0',
			sseg => led2
		);
	
	-- instanciar 4 MSBs de la entrada incrementada
	sseg_unit_4: entity work.hex_to_sseg
		port map(
			hex => d ,
			dp  => '0', -- punto desactivado, 1 para activar
			sseg => led3
			);
	
	-- instanciar el  7-seg LED display multiplexor de tiempo
	
	disp_unit: entity work.disp_mux
		port map(
			clk=>clk,
			rst=>'0',
			in0=>led3,
			in1=>led2,
			in2=>led1,
			in3=>led0, -- primer led de izquierda a derecha
			en=> an_negado,
			sseg=>sseg
		);
	
	an<= not an_negado;
	
end arch;
	
	
	
	
	
	
	
	

	
	
	
	
	
	
	
	