----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/28/2023 02:45:22 PM
-- Design Name: 
-- Module Name: control_unit - Behavioral
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

entity control_unit is
    port(
        clock, reset, go : in std_logic;
        flags : in std_logic_vector(2 downto 0);
        x_we, y_we : out std_logic;
        gcd : out std_logic_vector(8 downto 0)
    );
end control_unit;

architecture Behavioral of control_unit is
    type state_t is (start, input, test, decrement_x, decrement_y, done);
    signal current_state, next_state : state_t;
begin
state_register:
    process(clock, reset)
    begin
        if reset = '1' then
            current_state <= start;
        elsif rising_edge(clock) then
            current_state <= next_state;
        end if;
    end process;

machine_input:
    process(current_state)
    begin
        case current_state is
            when start =>
                if go = '1' then
                    next_state <= input;
                end if;
            when input =>
                next_state <= test;
            when test =>
                if flags = "010" then
                    next_state <= done;
                elsif flags = "100" then
                    next_state <= decrement_y;
                else
                    next_state <= decrement_x; 
                end if;
            when decrement_x =>
                next_state <= test;
            when decrement_y =>
                next_state <= test;
            when others =>
                null;
        end case;
    end process;

machine_output:
    process(clock, reset)
    begin
    
    end process;
end Behavioral;
