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
        x_we, y_we, x_sel, y_sel, gcd_we: out std_logic
    );
end control_unit;

architecture Behavioral of control_unit is
    type state_t is (start, input, test, update_x, update_y, done);
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
    end process state_register;

machine_input:
    process(current_state, flags, go)
    begin
        case current_state is
            when start =>
                if go = '1' then
                    next_state <= input;
                else
                    next_state <= start;
                end if;
            when input =>
                next_state <= test;
            when test =>
                if flags = "010" then
                    next_state <= done;
                elsif flags = "100" then
                    next_state <= update_y;
                else
                    next_state <= update_x;
                end if;
            when update_x =>
                next_state <= test;
            when update_y =>
                next_state <= test;
            when done =>
                next_state <= done;
            when others =>
                null;
        end case;
    end process machine_input;

machine_output:
    process(current_state)
    begin
        case current_state is
            when start =>
                x_sel <= '1';
                y_sel <= '1';
                x_we <= '0';
                y_we <= '0';
                gcd_we <= '0';
            when input =>
                x_sel <= '1';
                y_sel <= '1';
                x_we <= '1';
                y_we <= '1';
            when test =>
                x_we <= '0';
                y_we <= '0';
            when update_x =>
                x_sel <= '0';
                x_we <= '1';
                y_we <= '0';
            when update_y =>
                y_sel <= '0';
                y_we <= '1';
                x_we <= '0';
            when done =>
                x_we <= '0';
                y_we <= '0';
                gcd_we <= '1';
            when others =>
                 null;
        end case;
    end process machine_output;
end Behavioral;
