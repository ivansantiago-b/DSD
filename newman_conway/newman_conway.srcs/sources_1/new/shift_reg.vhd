----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/19/2023 04:40:30 PM
-- Design Name: 
-- Module Name: shift_reg - Behavioral
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

entity shift_reg is
    generic(
        n : integer := 8
    );
    port(
        clock, clear, sh, we : in std_logic;
        d : in std_logic_vector(n - 1 downto 0);
        q : out std_logic_vector(n - 1 downto 0)
    );
end shift_reg;

architecture Behavioral of shift_reg is
    signal data : std_logic_vector(n - 1 downto 0);
begin
    process(clock, clear, we, sh)
    begin
        if clear = '1' then
            data <= (others => '0');
        elsif rising_edge(clock) then
            if we = '1' then
                data <= d;
            elsif sh = '1' then
                data <= data(n - 2 downto 0) & '0';
            end if;
        end if;
    end process;
    q <= data;
end Behavioral;
