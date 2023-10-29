//
//  ProfileView.swift
//
import UIKit

class ProfileView: UIView {
    private struct Constants {
        static let defaultAvatar: String = "DefaultAvatar"
        static let saveTitle: String = "Сохранить"
        static let cancelTitle: String = "Отмена"
        static let avatarRadius: CGFloat = 120
        static let offset: CGFloat = 10
        static let horizontalOffset: CGFloat = 20
        static let topOffset: CGFloat = 20
        static let fieldHeight: CGFloat = 40
    }
    // MARK: - Fields
    let avatarImage = UIImageView()

    let firstNameField = UITextField()
    let secondNameField = UITextField()
    let middleNameField = UITextField()
    let nicknameField = UITextField()
    let emailField = UITextField()
    let telegramField = UITextField()

    let saveButton = UIButton()
    let cancelButton = UIButton()
    
    let completeTitle = UILabel()

    /// Buttons actions.
    public var saveAction: (() -> Void)?
    public var cancelAction: (() -> Void)?

    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    public func configure(profile: ProfileModel) {
        avatarImage.image = profile.avatar?.toImage() ?? UIImage(named: Constants.defaultAvatar)
        firstNameField.text = profile.firstName
        secondNameField.text = profile.secondName
        middleNameField.text = profile.middleName
        nicknameField.text = profile.nickname
        emailField.text = profile.email
        telegramField.text = profile.telegram
    }

    public func setAvatar(_ avatar: String) {
        avatarImage.image = avatar.toImage()
    }

    public func setAvatar(_ avatar: UIImage) {
        avatarImage.image = avatar
    }

    // MARK: - Private methods

    private func configureUI() {
        self.backgroundColor = .white
        configureAvatar()
        configureFields()
        configureButtons()
        configureLabels()
    }

    private func configureAvatar() {
        self.addSubview(avatarImage)
        avatarImage.layer.masksToBounds = true
        avatarImage.layer.cornerRadius = Constants.avatarRadius
        avatarImage.setWidth(Constants.avatarRadius * 2)
        avatarImage.setHeight(Constants.avatarRadius * 2)
        avatarImage.pinCenterX(to: self)
        avatarImage.pinTop(to: self, Constants.topOffset)
        avatarImage.backgroundColor = .white
        avatarImage.image = UIImage(named: Constants.defaultAvatar)
    }

    private func configureFields() {
        configureField(firstNameField)
        firstNameField.pinTop(to: avatarImage.bottomAnchor, Constants.offset)
        firstNameField.placeholder = "Имя"

        configureField(secondNameField)
        secondNameField.pinTop(to: firstNameField.bottomAnchor, Constants.offset)
        secondNameField.placeholder = "Фамилия"
        
        configureField(middleNameField)
        middleNameField.pinTop(to: secondNameField.bottomAnchor, Constants.offset)
        middleNameField.placeholder = "Отчество"
        
        configureField(nicknameField)
        nicknameField.pinTop(to: middleNameField.bottomAnchor, Constants.offset)
        nicknameField.placeholder = "Никнейм"
        
        configureField(emailField)
        emailField.pinTop(to: nicknameField.bottomAnchor, Constants.offset)
        emailField.placeholder = "Электронная почта"
        emailField.keyboardType = UIKeyboardType.emailAddress
        
        configureField(telegramField)
        telegramField.pinTop(to: emailField.bottomAnchor, Constants.offset)
        telegramField.placeholder = "Telegram(если есть)"
    }

    /// Configure UITextField for displaying under each other.
    private func configureField(_ field: UITextField) {
        self.addSubview(field)
        field.pinHorizontal(to: self, Constants.horizontalOffset)
        field.setHeight(Constants.fieldHeight)
        field.resignFirstResponder()
        field.selectedTextRange = nil
        field.textColor = .black
        field.autocapitalizationType = .none
    }

    /// Configure save and cancel buttons.
    private func configureButtons() {
        let view = UIView()
        self.addSubview(view)
        view.pinBottom(to: self, Constants.offset)
        view.pinHorizontal(to: self, Constants.horizontalOffset)

        view.addSubview(saveButton)
        saveButton.pinBottom(to: view, Constants.offset)
        saveButton.setTitle(Constants.saveTitle, for: .normal)
        saveButton.pinRight(to: view)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.addTarget(self, action: #selector(save), for: .touchUpInside)

        view.addSubview(cancelButton)
        cancelButton.pinBottom(to: view, Constants.offset)
        cancelButton.pinLeft(to: view)
        cancelButton.setTitle(Constants.cancelTitle, for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)

        view.pinHeight(to: saveButton.heightAnchor)
    }
    
    private func configureLabels() {
        self.addSubview(completeTitle)
        completeTitle.pinBottom(to: saveButton.topAnchor, Constants.offset)
        completeTitle.pinHorizontal(to: self, Constants.horizontalOffset)
        completeTitle.setHeight(Constants.fieldHeight)
        completeTitle.textColor = .black
    }

    @objc
    private func save() {
        if (validate()) {
            completeTitle.text = "Данные сохранены."
            saveAction?()
        } else {
            completeTitle.text = "Заполните обязательные поля."
            firstNameField.placeholder = "Обязательное поле"
            
            secondNameField.placeholder = "Обязательное поле"
            
            nicknameField.placeholder = "Обязательное поле"
        
            emailField.placeholder = "Обязательное поле"
        }
    }

    @objc
    private func cancel() {
        cancelAction?()
    }
    
    private func validate() -> Bool {
        if let text = firstNameField.text, !text.isEmpty {
            if let text = secondNameField.text, !text.isEmpty {
                if let text = emailField.text, !text.isEmpty {
                    if let text = nicknameField.text, !text.isEmpty {
                        return true;
                    }
                }
            }
        }
        return false;
    }
}
