----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/29/2023 08:44:30 AM
-- Design Name: 
-- Module Name: pixel_clock - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity pixel_clock is
    port(
        sys_clk, clear : in std_logic;
        px_clk : out std_logic
    );
end pixel_clock;

architecture Behavioral of pixel_clock is
    signal whole_count, half_count : unsigned(2 downto 0);
    signal whole, half : std_logic;
begin
    process(sys_clk, clear, half_count)
    begin
        if clear = '1' then
            whole_count <= "000";
            whole <= '0';
        elsif rising_edge(sys_clk) then
            if (half_count = "100" or whole_count > "100") then
                whole_count <= "000";
                whole <= '1';
            else
                whole_count <= half_count + "001";
                whole <= '0';
            end if;
        end if;
    end process;
    
    process(sys_clk, clear, whole_count)
    begin
        if clear = '1' then
            half_count <= "000";
            half <= '0';
        elsif falling_edge(sys_clk) then
            if (whole_count = "100" or half_count > "100") then
                half_count <= "000";
                half <= '1';
            else
                half_count <= whole_count + "001";
                half <= '0';
            end if;
        end if;
    end process;
    
    px_clk <= whole or half;
end Behavioral;
