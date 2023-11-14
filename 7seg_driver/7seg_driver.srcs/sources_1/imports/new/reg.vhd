----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2023 12:20:10 AM
-- Design Name: 
-- Module Name: reg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg is
    generic(
        n : integer := 8
    );
    port(
        clock, clear, we : in std_logic;
        data_in : in std_logic_vector(n - 1 downto 0);
        data_out : out std_logic_vector(n - 1 downto 0)
    );
end reg;

architecture Behavioral of reg is

begin
    process(clock, clear)
    begin
        if clear = '1' then
            data_out <= (others => '0');
        elsif rising_edge(clock) then
            if we = '1' then
                data_out <= data_in;
            end if;
        end if;
    end process;

end Behavioral;
