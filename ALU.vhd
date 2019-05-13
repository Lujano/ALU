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
	signal inc: std_logic_vector (7 downto 0) ;
	signal led3, led2, led1, led0: std_logic_vector (7 downto 0) ;
	signal an_negado: std_logic_vector(3 downto 0);
begin
	-- incrementar entrada
	inc <= std_logic_vector(unsigned(sw)+1);
	-- instanciar cuatro instancias de hex-decoders
	-- instanciar para cuatro LSBs de las entradas
	
	-- el formato del decoder es punto abcdefg
	sseg_unit_0: entity work.hex_to_sseg
		port map(
			hex => "0001" ,
			dp  => '0',
			sseg => led0 -- Primer led izquierda a derecha
		);
	
	-- instanciar 4 MSBs de la entrada
	sseg_unit_1: entity work.hex_to_sseg
		port map(
			hex => "0010" ,
			dp  => '0',
			sseg => led1
		);
	
	
	-- instanciar 4 LSBs de la entrada incrementada
	sseg_unit_3: entity work.hex_to_sseg
		port map(
			hex => "0100" ,
			dp  => '0',
			sseg => led2
		);
	
	-- instanciar 4 MSBs de la entrada incrementada
	sseg_unit_4: entity work.hex_to_sseg
		port map(
			hex => "1000" ,
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
	
	
	
	
	
	
	
	
	