library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter4 is
    port (clk, reset : in  std_logic;
          count      : out unsigned(3 downto 0));
end entity;

architecture rtl of counter4 is
    signal c : unsigned(3 downto 0) := (others => '0');
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then c <= (others => '0');
            else c <= c + 1;
            end if;
        end if;
    end process;
    count <= c;
end architecture;
