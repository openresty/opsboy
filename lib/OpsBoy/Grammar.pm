package OpsBoy::Grammar;
use Pegex::Base;
extends 'Pegex::Grammar';

use constant file => 'share/opsboy.pgx';

sub make_tree {   # Generated/Inlined by Pegex::Grammar (0.60)
  {
    '+toprule' => 'specification',
    'argument' => {
      '.any' => [
        {
          '.ref' => 'single_quoted_string'
        },
        {
          '.ref' => 'back_quoted_string'
        },
        {
          '.ref' => 'unquoted_string'
        }
      ]
    },
    'assignment' => {
      '.all' => [
        {
          '.ref' => 'identifier'
        },
        {
          '.rgx' => qr/\G=/
        },
        {
          '.ref' => 'argument'
        },
        {
          '-skip' => 1,
          '.ref' => 'terminator'
        }
      ]
    },
    'back_quoted_string' => {
      '.rgx' => qr/\G(?:[\ \t]|\r?\n|\#.*\r?\n)*(`[^`]*`)(?:[\ \t]|\r?\n|\#.*\r?\n)*/
    },
    'block' => {
      '.all' => [
        {
          '.rgx' => qr/\G(?:[\ \t]|\r?\n|\#.*\r?\n)*\{/
        },
        {
          '+min' => 0,
          '.ref' => 'rule'
        },
        {
          '.rgx' => qr/\G\}(?:[\ \t]|\r?\n|\#.*\r?\n)*/
        }
      ]
    },
    'command' => {
      '.rgx' => qr/\G(?:[\ \t]|\r?\n|\#.*\r?\n)*\b(git|file|running|dir|dep|cwd|test|env|always|sh|yum|debuginfo|prog|fetch|tarball|cpan)\b(?:[\ \t]|\r?\n|\#.*\r?\n)*/
    },
    'identifier' => {
      '.rgx' => qr/\G(?:[\ \t]|\r?\n|\#.*\r?\n)*([a-zA-Z][\-\w]*)(?:[\ \t]|\r?\n|\#.*\r?\n)*/
    },
    'rule' => {
      '.all' => [
        {
          '.ref' => 'command'
        },
        {
          '+min' => 0,
          '.ref' => 'argument'
        },
        {
          '-skip' => 1,
          '.ref' => 'terminator'
        }
      ]
    },
    'single_quoted_string' => {
      '.rgx' => qr/\G(?:[\ \t]|\r?\n|\#.*\r?\n)*('(?:\\.|[^\\\n'])*')(?:[\ \t]|\r?\n|\#.*\r?\n)*/
    },
    'specification' => {
      '+min' => 0,
      '.ref' => 'statement'
    },
    'statement' => {
      '.any' => [
        {
          '.ref' => 'assignment'
        },
        {
          '.ref' => 'target_definition'
        }
      ]
    },
    'target_definition' => {
      '.all' => [
        {
          '.ref' => 'identifier'
        },
        {
          '.ref' => 'block'
        }
      ]
    },
    'terminator' => {
      '.rgx' => qr/\G;(?:[\ \t]|\r?\n|\#.*\r?\n)*/
    },
    'unquoted_string' => {
      '.rgx' => qr/\G(?:[\ \t]|\r?\n|\#.*\r?\n)*([^"`;\s]+)(?:[\ \t]|\r?\n|\#.*\r?\n)*/
    }
  }
}

1;
