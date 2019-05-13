library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALA is -- Multiplexacion por tiempo de 7 segmentos
	port(
		a: in std_logic_vector(3 downto 0);    --entrada A de la ALU
		b : in std_logic_vector(3 downto 0);   -- entrade B de la ALU
		op : in std_logic_vector(1 downto 0) ;  -- selector de operacion
		r : out std_logic_vector(3 downto 0);  -- resultado de la ALU
		c : out std_logic ;                    -- control de desbordamiento
		d : out std_logic_vector(3 downto 0)   -- salida de operacion actual(para 7 segmentos)		
	);
	end ALA;
	
	
architecture arch of ALA is
begin

	with op select
		r <=
			"0000" when "00",
			a+b    when "01",
			a-b    when "10",
			a		 when "11";
			
			
	with op select   -- operacion actual
	 d <=
		"0000" when "00",
		"0001"  when "01",
		"0010"  when "10",
		"0011"  when "11";
		
		--c = "1"; -- mientras tanto
	
end arch;