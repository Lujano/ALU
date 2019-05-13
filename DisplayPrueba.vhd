library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALUS is -- Multiplexacion por tiempo de 7 segmentos
	port(
		sw: in std_logic_vector(3 downto 0); -- Primer valor a mostrar
		sseg : out std_logic_vector(7 downto 0); -- salida comun de los 7 segmentos
		an : out std_logic_vector(3 downto 0)   -- anodos de los 7 segmentos
	);
	
	end ALUS;
	
	
architecture arch of ALUS is
begin
	-- incrementar entrada
	inc <= std_logic_vector(unsigned(sw)+1);
	-- instanciar cuatro instancias de hex-decoders
	-- instanciar para cuatro LSBs de las entradas
	sseg_unit_0: entity work.hex_to_sseg
		port map(
			hex => sw(3 downto 0) ,
			dp  => '0',
			sseg => led0
		);
	
	-- instanciar 4 MSBs de la entrada
	sseg_unit_1: entity work.hex_to_sseg
		port map(
			hex => sw(7 downto 4) ,
			dp  => '0',
			sseg => led1
		);
	
	
	-- instanciar 4 LSBs de la entrada incrementada
	sseg_unit_3: entity work.hex_to_sseg
		port map(
			hex => inc(3 downto 0) ,
			dp  => '1',
			sseg => led2
		);
	
	-- instanciar 4 MSBs de la entrada incrementada
	sseg_unit_4: entity work.hex_to_sseg
		port map(
			hex => inc(7 downto 4) ,
			dp  => '1',
			sseg => led3
			);
	
	-- instanciar el  7-seg LED display multiplexor de tiempo
	
	disp_unit: entity work.disp_mux
		port map(
			clk=>clk,
			rst=>'0',
			in0=>led0,
			in1=>led1,
			in2=>led2,
			in3=>led3,
			en=>an,
			sseg=>sseg
		);
	
end arch;
	
	
	
	
	
	
	
	
	