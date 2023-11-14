----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/21/2023 11:45:24 PM
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
        clock, clear, we, se : in std_logic;
        data_in : in std_logic_vector(n - 1 downto 0);
        data_out : out std_logic_vector(n - 1 downto 0)
    );
end shift_reg;

architecture Behavioral of shift_reg is
    signal data : std_logic_vector(n - 1 downto 0);
begin
    process(clock, clear)
    begin
        if clear = '1' then
            data <= (others => '0');
        elsif rising_edge(clock) then
            if we = '1' then
                data <= data_in;
            elsif se = '1' then
                data <= data(n - 2 downto 0) & '0';
            end if;
        end if;
    end process;
    data_out <= data;
end Behavioral;
