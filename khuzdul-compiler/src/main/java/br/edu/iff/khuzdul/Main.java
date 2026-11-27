package br.edu.iff.khuzdul;

import java.io.IOException;
import java.nio.file.Path;
import org.antlr.v4.runtime.*;

public class Main {
    public static void main(String[] args) throws IOException {
        CharStream input;
        if (args.length == 0) {
            try (java.io.InputStream stream = Main.class.getResourceAsStream("/avaliacao_aluno.khuzdul")) {
                if (stream == null) {
                    throw new IOException("Exemplo Khuzdul não encontrado.");
                }
                input = CharStreams.fromStream(stream);
            }
        } else {
            input = CharStreams.fromPath(Path.of(args[0]));
        }

        KhuzdulLexer lexer = new KhuzdulLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        tokens.fill();
        for (Token token : tokens.getTokens()) {
            System.out.printf("%-18s %s%n", lexer.getVocabulary().getSymbolicName(token.getType()), token.getText());
        }
        KhuzdulParser parser = new KhuzdulParser(tokens);
        KhuzdulParser.ProgramaContext programa = parser.programa();
        if (parser.getNumberOfSyntaxErrors() == 0) {
            System.out.println(programa.toStringTree(parser));
        }
    }
}
