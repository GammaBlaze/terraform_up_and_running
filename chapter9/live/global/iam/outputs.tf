output "user_arns" {
  value       = aws_iam_user.example[*].arn
  description = "The ARNs of the created IAM users"
}

output "upper_names" {
  value = [for name in var.user_names : upper(name)]
}

output "short_upper_names" {
  value = [for name in var.user_names : upper(name) if length(name) < 5]
}

output "bios" {
  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
}

output "upper_roles" {
  value = { for name, role in var.hero_thousand_faces : upper(name) => upper(role) }
}

output "for_directive" {
  value = "%{for name in var.user_names}${name}, %{endfor}"
}

output "for_directive_index" {
  value = "%{for i, name in var.user_names}(${i}) ${name}, %{endfor}"
}

output "for_directive_index_if_else_strip" {
  value = <<EOF
%{~for i, name in var.user_names~}
${name}%{if i < length(var.user_names) - 1}, %{else}.%{endif}
%{~endfor~}
EOF
}

output "neo_cloudwatch_policy_arn" {
  value = one(concat(
    aws_iam_user_policy_attachment.neo_cloudwatch_full_access[*].policy_arn,
    aws_iam_user_policy_attachment.neo_cloudwatch_read_only[*].policy_arn
  ))
}
