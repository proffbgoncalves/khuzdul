/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */
package br.edu.iff.khuzdul;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Token;

/**
 *
 * @author fbarr
 */
public class Main {

    public static void main(String[] args) throws IOException {
        InputStream stream = Main.class.getResourceAsStream(
                "/avaliacao_aluno.khuzdul");
        if (stream == null) {
            throw new IllegalStateException("Arquivo .khuzdul nao encontrado.");
        }

        CharStream input = CharStreams.fromStream(stream, StandardCharsets.UTF_8);
        KhuzdulLexer lexer = new KhuzdulLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        tokens.fill();
        for (Token token : tokens.getTokens()) {
        String name = KhuzdulLexer.VOCABULARY
        .getSymbolicName(token.getType());
        System.out.printf("%-18s %s%n", name, token.getText());
        }
    }
}
