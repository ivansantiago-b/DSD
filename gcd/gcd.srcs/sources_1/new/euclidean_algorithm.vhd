----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/13/2023 03:03:53 PM
-- Design Name: 
-- Module Name: euclidean_algorithm - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity euclidean_algorithm is
    generic(
        n : integer := 4
    );
    
    port(
        clock, clear, go : in std_logic;
        x_in, y_in : in std_logic_vector(n - 1 downto 0);
        gcd : out std_logic_vector(n - 1 downto 0);
        done : out std_logic
    );
end euclidean_algorithm;

architecture Behavioral of euclidean_algorithm is
    signal x, y : std_logic_vector(n - 1 downto 0);
begin
    process(clock, clear)
    variable calc : std_logic;
    variable donev : std_logic;
    begin
        if clear = '1' then
            x <= (others => '0');
            y <= (others => '0');
            gcd <= (others => '0');
            donev := '1';
            calc := '0';
        elsif rising_edge(clock) then
            donev := '0';
            if go = '1' then
                x <= x_in;
                y <= y_in;
                calc := '1';
            elsif calc = '1' then
                if x = y then
                    gcd <= x;
                    donev := '1';
                    calc := '0';
                elsif x < y then
                    y <= y - x;
                else
                    x <= x - y;
                end if;
            end if;
        end if;
        done <= donev;
    end process;

end Behavioral;
