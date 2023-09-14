----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2023 09:03:18 PM
-- Design Name: 
-- Module Name: debounce - Behavioral
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

entity debounce is
    generic(
        n : integer := 4
    );
    port(
        clock, reset : in std_logic;
        input : in std_logic_vector(n - 1 downto 0);
        output : out std_logic_vector(n - 1 downto 0)
        --button : out std_logic_vector(1 downto 0)
    );
end debounce;

architecture Behavioral of debounce is
    signal first_delay, second_delay, third_delay : std_logic_vector(n - 1 downto 0);
begin
    process(clock, reset)
    begin
        if reset = '1' then
            first_delay <= (others => '0');
            second_delay <= (others => '0');
            third_delay <= (others => '0');
        elsif rising_edge(clock) then
            first_delay <= input;
            second_delay <= first_delay;
            third_delay <= second_delay;
        end if;
    end process;
    output <= first_delay and second_delay and third_delay;
    --with input select
    --    button <= "00" when "001",
    --              "01" when "010",
    --              "10" when "100",
    --              "11" when others;
end Behavioral;
