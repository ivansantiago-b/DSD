----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/06/2023 10:44:42 AM
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
use IEEE.NUMERIC_STD.ALL;

entity shift_reg is
    generic(n : integer := 8);
    port(
        clock, reset, we, en, r_in, r_we : in std_logic;
        data_in : in std_logic_vector(n - 1 downto 0);
        data_out : out std_logic_vector(n - 1 downto 0)
    );
end shift_reg;

architecture Behavioral of shift_reg is
    signal data : std_logic_vector(n - 1 downto 0);
    signal r : std_logic;
begin
    process(clock, reset, we, en)
    begin
        if reset = '1' then
            data <= (others => '0');
            r <= '0';
        elsif rising_edge(clock) then
            if we = '1' then
                data <= data_in;
            end if;
            if r_we = '1' then
                r <= r_in;
            end if;
            if en = '1' then
                data <= std_logic_vector(shift_left(unsigned(data), 1));
                data(0) <= r;
            end if;
        end if;
    end process;
    
    data_out <= data;
end Behavioral;
